// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/graphql/graphql_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AbsenceController extends GetxController {
  final obscureText = true.obs;
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  final GlobalController cGlobal = Get.find<GlobalController>();

  Future<bool> createAbsence(XFile file, Map<String, dynamic> input) async {
    try {
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

      final variables = {
        'input': {'lat': input['lat'], 'lng': input['lng']},
        'file': multipartFile,
      };

      final Map<String, dynamic>? response = await GraphQLBase().mutate(
        mutation,
        variables: variables,
      );

      if (response == null) {
        log('Response null dari server');
        return false;
      }

      log('Response absensi: $response');
      return true;
    } catch (e, stackTrace) {
      log('Error saat createAbsence: $e');
      log('StackTrace: $stackTrace');
      return false;
    }
  }
}
