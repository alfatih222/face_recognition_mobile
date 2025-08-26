// ignore_for_file: library_private_types_in_public_api, use_super_parameters, unused_field

import 'dart:async';

import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/controllers/setting_controller.dart';
import 'package:facerecognition/views/auth/login_view.dart';
import 'package:facerecognition/views/home/home_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  _IndexScreenPageState createState() => _IndexScreenPageState();
}

class _IndexScreenPageState extends State<IndexScreen> {
  final GlobalController cGlobal = Get.put(GlobalController());
  final SettingController settingController = Get.put(SettingController());
  late Timer _settingTimer;
  @override
  void initState() {
    super.initState();

    settingController.fetchSetting();
    _settingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      settingController.fetchSetting();
    });

    Future.delayed(const Duration(seconds: 2), () async {
      await cGlobal.init();

      if (cGlobal.getToken() != null) {
        Get.offAll(() => const HomeNavbarButton());
      } else {
        Get.offAll(() => LoginView());
      }
    });
  }

  @override
  void dispose() {
    _settingTimer.cancel(); // Stop timer saat screen dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final backgroundUrl = settingController.setting.value?.background;
      final logo = settingController.setting.value?.logoSekolah;

      return Container(
        decoration: BoxDecoration(
          color: const Color(0xffE2E3E3),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: backgroundUrl != null && backgroundUrl.isNotEmpty
                ? NetworkImage(
                    'http://${mainbaseFile}/uploads/sekolah/background/${backgroundUrl}',
                  )
                : const AssetImage('assets/images/background_one-medix.png')
                      as ImageProvider,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: getNoAppBar(),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (logo != null && logo.isNotEmpty)
                      logo.endsWith('.svg')
                          ? SvgPicture.network(
                              'http://${mainbaseFile}/uploads/sekolah/logo/$logo',
                              width: 150,
                            )
                          : Image.network(
                              'http://${mainbaseFile}/uploads/sekolah/logo/$logo',
                              width: 150,
                            )
                    else
                      SvgPicture.asset(
                        "assets/images/one-medix-logo.svg",
                      ), // fallback logo
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
