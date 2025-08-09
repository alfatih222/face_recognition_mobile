import 'package:facerecognition/components/widgets/alertx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const String mainBaseUrl = 'http://192.168.67.204:3000/graphql';
const String mainbaseFile = '';

class GlobalController extends GetxController with WidgetsBindingObserver {
  static GlobalController get to => Get.find();
  final box = GetStorage();
  static const String lastActiveKey = 'last_active_timestamp';

  Future<GlobalController> init() async {
    WidgetsBinding.instance.addObserver(this);
    _updateLastActive();

    _checkIdleOnStart();
    initState();
    return this;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _updateLastActive();
    }
  }

  void _updateLastActive() {
    final now = DateTime.now().millisecondsSinceEpoch;
    box.write(lastActiveKey, now);
  }

  void _checkIdleOnStart() {
    final lastActive = box.read(lastActiveKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    final diff = now - lastActive;

    const idleThreshold = 500000;
    if (diff > idleThreshold) {
      _clearStorage();
    }
  }

  void _clearStorage() {
    box.erase();
  }

  final _isDark = false.obs;
  get isDark => _isDark.value;
  void switchTheme() {
    _isDark.value = !_isDark.value;
    box.write('darkmode', !isDark);
  }

  String baseUrl = mainBaseUrl;
  String baseFile = mainbaseFile;

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
