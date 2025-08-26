// ignore_for_file: avoid_print, unused_field

import 'dart:async';

import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/components/widgets/text_field.dart';
import 'package:facerecognition/controllers/auth_controller.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/controllers/setting_controller.dart';
import 'package:facerecognition/views/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final SettingController settingController = Get.put(SettingController());
  bool _obscurePassword = true;
  late Timer _settingTimer;
  @override
  void initState() {
    super.initState();
    settingController.fetchSetting();
    _settingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      settingController.fetchSetting();
    });
  }

  @override
  void dispose() {
    _settingTimer.cancel(); // Stop timer saat screen dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffE2E3E3),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bc.jpg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: getNoAppBar(),
        body: Form(
          key: _key,
          child: GetBuilder<LoginController>(
            init: LoginController(),
            initState: (_) {},
            builder: (c) {
              return SingleChildScrollView(
                // Biar bisa scroll jika keyboard muncul / layar kecil
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            final logo =
                                settingController.setting.value?.logoSekolah;
                            if (logo != null && logo.isNotEmpty) {
                              if (logo.endsWith('.svg')) {
                                return SvgPicture.network(
                                  'http://$mainbaseFile/uploads/sekolah/logo/$logo',
                                  width: 150,
                                  height: 150,
                                );
                              } else {
                                return Image.network(
                                  'http://$mainbaseFile/uploads/sekolah/logo/$logo',
                                  width: 150,
                                  height: 150,
                                );
                              }
                            } else {
                              return SvgPicture.asset(
                                "assets/images/one-medix-logo.svg",
                                width: 150,
                                height: 150,
                              );
                            }
                          }),
                          const SizedBox(height: 48),

                          // Email Field
                          CTextField(
                            title: 'Email',
                            icon: Icons.email_outlined,
                            size: 20,
                            hint: 'Masukkan alamat email Anda',
                            inputType: TextInputType.emailAddress,
                            controller: c.emailController,
                          ),
                          const SizedBox(height: 18),

                          // Password Field dengan toggle
                          CTextField(
                            title: 'Password',
                            icon: Icons.lock_outlined,
                            size: 20,
                            hint: 'Masukkan password',
                            inputType: TextInputType.emailAddress,
                            controller: c.passwordController,
                            obscureText: _obscurePassword,
                            suffix: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 38),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: SizedBox(
                              height: 38,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    c.loginByEmail();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    1,
                                    85,
                                    1,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            "atau",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: SizedBox(
                              height: 38,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(RegisterView());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    1,
                                    85,
                                    1,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
