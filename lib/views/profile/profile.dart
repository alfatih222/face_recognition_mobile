import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/components/widgets/profile_list.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:facerecognition/views/absen/absen.dart';
import 'package:facerecognition/views/auth/login_view.dart';
import 'package:facerecognition/views/profile/profile_edit.dart';
import 'package:facerecognition/views/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Profile"),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: ListView(
        children: [
          // Header
          Container(
            height: 10.h,
            decoration: BoxDecoration(
              color: OprimaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // List Menu
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            'assets/images/placeholder.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jalal',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'NIP: 1540580',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ProfileListTile(
                  title: 'My Profile',
                  icon: Icon(Icons.person_outline),
                  onTap: () => Get.to(const ProfileEditView()),
                ),
                const Divider(thickness: 0.1),
                ProfileListTile(
                  title: 'Setting',
                  icon: Icon(Icons.settings_outlined),
                  onTap: () => Get.to(const SettingEditView()),
                ),
                const Divider(thickness: 0.1),
                ProfileListTile(
                  title: 'Report Absen',
                  icon: Icon(Icons.payment_outlined),
                  onTap: () => Get.to(const AbsenView()),
                ),
                const Divider(thickness: 0.1),
                ProfileListTile(
                  title: 'Logout',
                  icon: Icon(Icons.logout),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: const Text("Konfirmasi"),
                          content: const Text(
                            "Apakah Anda yakin ingin keluar?",
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Batal"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                              child: const Text("Keluar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                GlobalController.to.logout();
                                Get.to(LoginView());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
