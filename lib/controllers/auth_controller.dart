import 'dart:developer';
import 'dart:io';

import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/graphql/graphql_base.dart';
import 'package:facerecognition/views/home/home_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as HttpMultipartFile;
import 'package:http_parser/http_parser.dart';

class LoginController extends GetxController {
  Rx<bool> obscureText = true.obs;
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  final cGlobal = Get.find<GlobalController>();

  Future<void> loginByEmail() async {
    String q =
        '''
      mutation {
      login(
    input: { email: "${emailController.text}", password: "${passwordController.text}" }
  ) {
    ... on AuthUserResponse {
      token, user{
        role_id, id, email
      }
    }
    ... on Error {
      message
    }
  }
    }
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      // var a = res!['loginByEmail'][0]['__typename'];
      if (res != null) {
        String token = res['login'][0]['token'];
        String id = res['login'][0]['user']['id'];
        cGlobal.setId(id);
        cGlobal.setToken(token);
        log(id.toString());
        Get.offAll(() => const HomeNavbarButton());
      }
    } on Error catch (e, s) {
      log('ini error e $e');
      log('ini error s :$s');
    }
  }
}

class RegisterController extends GetxController {
  Rx<bool> obscureText = true.obs;
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final fullnameController = TextEditingController(text: "");

  final cGlobal = Get.find<GlobalController>();

  Future<void> register(File file) async {
    var multipartFile = await HttpMultipartFile.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: MediaType("image", "jpeg"),
    );

    const String mutation = r'''
    mutation Register($input:RegisterInput!, $file: Upload!) {
      register(
        input: $input,
        file: $file
      ) {
        ... on AuthUserResponse {
          token,
          user{
          id,
          email
          }
        }
        ... on Error {
          message
        }
        ... on ErrorResponse {
          message
        }
      }
    }
  ''';

    final Map<String, dynamic> variables = {
      'input': {
        'email': emailController.text,
        'password': passwordController.text,
        'fullname': fullnameController.text,
      },
      'file': multipartFile,
    };
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(
        mutation,
        variables: variables,
      );
      if (res != null) {
        String token = res['register'][0]['token'];
        String id = res['register'][0]['user']['id'];
        cGlobal.setId(id);
        cGlobal.setToken(token);
        log(id.toString());
        Get.offAll(() => const HomeNavbarButton());
      }
    } on Error catch (e, s) {
      log('ini error e $e');
      log('ini error s :$s');
    }
  }
}
