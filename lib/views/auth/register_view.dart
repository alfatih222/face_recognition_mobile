import 'dart:io';

import 'package:facerecognition/components/widgets/alertx.dart';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/components/widgets/text_field.dart';
import 'package:facerecognition/controllers/auth_controller.dart';
import 'package:facerecognition/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final alert = Alertx();

  File? _imageFile;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
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
        body: Form(
          key: _key,
          child: GetBuilder<RegisterController>(
            init: RegisterController(),
            initState: (_) {},
            builder: (c) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _takePicture,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : null,
                      child: _imageFile == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 32,
                              color: Colors.black45,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CTextField(
                    title: 'Email',
                    icon: Icons.email_outlined,
                    size: 20,
                    hint: 'Masukkan alamat email Anda',
                    inputType: TextInputType.emailAddress,
                    controller: c.emailController,
                  ),
                  const SizedBox(height: 18),
                  CTextField(
                    title: 'Password',
                    icon: Icons.lock_outlined,
                    size: 20,
                    hint: 'Masukkan password',
                    inputType: TextInputType.visiblePassword,
                    controller: c.passwordController,
                  ),
                  const SizedBox(height: 18),
                  CTextField(
                    title: 'Konfirmasi Password',
                    icon: Icons.lock_outline,
                    size: 20,
                    hint: 'Masukkan ulang password',
                    inputType: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 38),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SizedBox(
                      height: 38,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_imageFile == null) {
                            Get.snackbar(
                              "Error",
                              "Harap pilih gambar terlebih dahulu",
                            );
                            return;
                          }
                          if (c.passwordController.text.trim() !=
                              confirmPasswordController.text.trim()) {
                            Get.snackbar(
                              "Error",
                              "Password dan konfirmasi password tidak sama",
                              backgroundColor: Colors.red.shade100,
                              colorText: Colors.black,
                            );
                            return;
                          }
                          c.register(_imageFile!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2D4B84),
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
                  const SizedBox(height: 20),

                  const Text(
                    "atau",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),

                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SizedBox(
                      height: 38,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(LoginView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2D4B84),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            "Login",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
