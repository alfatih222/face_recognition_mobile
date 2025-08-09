// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/graphql/graphql_base.dart';
import 'package:facerecognition/models/absen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class AbsenceController extends GetxController {
  final obscureText = true.obs;
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  final GlobalController cGlobal = Get.find<GlobalController>();

  Future<Map<String, dynamic>?> createAbsence(
    XFile file,
    Map<String, dynamic> input,
  ) async {
    final bytes = await file.readAsBytes();

    final multipartFile = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: 'face.jpg',
      contentType: MediaType("image", "jpeg"),
    );

    const String mutation = r'''
    mutation CreateAbsen($input: AbsenInput!, $file: Upload!) {
      createAbsen(
        input: $input,
        file: $file
      ) {
        ...on AttendanceResponse {
          message
          allow
        }
        ...on Error {
          message
        }
      }
    }
  ''';

    Map<String, dynamic> variables = {
      'input': {'lat': input['lat'], 'lng': input['lng']},
      'file': multipartFile,
    };

    try {
      final Map<String, dynamic>? response = await GraphQLBase().mutate(
        mutation,
        variables: variables,
      );
      if (response != null) {
        final List<dynamic> result = response['createAbsen'];

        if (result.isNotEmpty) {
          final data = result[0] as Map<String, dynamic>;
          final bool allow = data['allow'] ?? false;
          final String message = data['message'] ?? 'Tidak ada pesan';
          return {'allow': allow, 'message': message};
        }
      }
      return {'allow': false, 'message': 'Error'};
    } catch (e, stackTrace) {
      log('Error saat createAbsence: $e');
      log('StackTrace: $stackTrace');
      return {'allow': false, 'message': 'Error'};
    }
  }
}

class GetAbsenController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<Attendance> absens = <Attendance>[].obs;

  Future<void> fetchAbsensByUser(String userId, {String type = 'today'}) async {
    isLoading.value = true;
    errorMessage.value = '';
    absens.clear();

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String dateFilter = type == 'all' ? '' : 'date: {eq: "$today"},';

    final String query =
        '''
    query {
      absens(
        filter:{
           $dateFilter
          user_id:{eq:"$userId"}
        }
        paging:{
          limit:50,
          offset:0
        }
        sorting:[]
      ){
        ...on AbsenSyncConnection{
          nodes{
            id
            date
            lat
            lng
            checkIn
            checkOut
            type
            user_id
            user {
              id
              email
              role_id
            }
          }
        }
      }
    }
    ''';

    try {
      final res = await GraphQLBase().query(query);
      if (res != null && res['absens'] != null) {
        final List nodes = res['absens']['nodes'] as List<dynamic>;
        absens.addAll(nodes.map((e) => Attendance.fromJson(e)).toList());
      } else {
        errorMessage.value = 'Gagal mengambil data absensi';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
