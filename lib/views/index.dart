// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'dart:developer';

import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/views/auth/login_view.dart';
import 'package:facerecognition/views/home/home_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);
  @override
  _IndexScreenPageState createState() => _IndexScreenPageState();
}

class _IndexScreenPageState extends State<IndexScreen> {
  GlobalController cGlobal = Get.put(GlobalController());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      await cGlobal.initState();
      log("Bearer + ${cGlobal.token}");
      if (cGlobal.getToken() != null) {
        Get.offAll(() => const HomeNavbarButton());
      } else {
        Get.offAll(() => LoginView());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffE2E3E3),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_one-medix.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: getNoAppBar(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/one-medix-logo.svg"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
