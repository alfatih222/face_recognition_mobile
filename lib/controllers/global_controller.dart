import 'dart:developer';

import 'package:facerecognition/components/widgets/alertx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const String mainBaseUrl = 'http://192.168.67.204:3000/graphql';
const String mainbaseFile = '';

class GlobalController extends GetxController {
  Future<GlobalController> init() async {
    return this;
  }

  static GlobalController get to => Get.find();

  var selectLong = 0.0.obs;
  var selectLat = 0.0.obs;

  final tabHomeIndex = 0.obs;
  final box = GetStorage();
  final _isDark = false.obs;
  get isDark => _isDark.value;
  void switchTheme() {
    _isDark.value = !_isDark.value;
    log(_isDark.value.toString());
    // Get.changeTheme(_isDark.value == true ? AppTheme.dark : AppTheme.light);
    // Get.changeTheme(AppTheme.dark);
    box.write('darkmode', !isDark);
  }

  TextEditingController platNomor = TextEditingController();
  TextEditingController catatanLain = TextEditingController();

  var imageReport = "".obs;
  var imageReport2 = "".obs;
  var imageOpsional = "".obs;
  var adress = "".obs;
  var subCity = "".obs;
  var city = "".obs;
  var street = "".obs;
  var dataadress = "".obs;
  var detailAdress = "".obs;
  var jenisKendaraan = "Mobil".obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;
  var isAlready = ''.obs;
  String baseUrl = mainBaseUrl;
  String baseFile = mainbaseFile;
  String username = '';
  String phone = '';
  String profileImage = '';

  String token = '';
  String role = '';
  String id = '';

  void setToken(String val) {
    box.write('token', val);
    token = val;
  }

  void setRole(String val) {
    box.write('role', val);
    role = val;
  }

  void setId(String val) {
    box.write('id', val);
    role = val;
  }

  String? getRole() {
    String? token = box.read('role');
    return token;
  }

  String? getToken() {
    String? token = box.read('token');
    return token;
  }

  String? getId() {
    String? id = box.read('id');
    return id;
  }

  initState() {
    token = getToken() ?? '';
    role = getRole() ?? '';
    id = getId() ?? '';
  }

  logout() {
    Alertx().loading();
    box.remove("token");
    box.remove("role");
    box.remove("id");
    box.remove("loginBy");
    box.remove("id");
    box.remove("username");
    box.remove("profileImage");
    box.remove("setPhone");
    box.remove("fullName");
  }
}
