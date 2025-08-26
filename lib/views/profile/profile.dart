import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/components/widgets/profile_list.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/controllers/user_controller.dart';
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
    final meController = Get.put(MeController());
    final d = mainbaseFile;
    // Fetch profile data (jika belum)
    if (meController.profile.value == null) {
      meController.fetchMe();
    }

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
                      Obx(() {
                        final photoUrl =
                            meController.profile.value?.profilePhotoUrl;
                        return SizedBox(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.white,
                            backgroundImage: photoUrl != null
                                ? NetworkImage(
                                    photoUrl.replaceAll('localhost:3000', d),
                                  )
                                : const AssetImage(
                                        'assets/images/placeholder.png',
                                      )
                                      as ImageProvider,
                          ),
                        );
                      }),

                      const SizedBox(width: 15),

                      // Nama & NIP
                      Obx(() {
                        final profile = meController.profile.value;
                        final name = profile?.fullname ?? '-';
                        final nip = profile?.nip ?? '-';

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'NIP: $nip',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Menu Items
                ProfileListTile(
                  title: 'My Profile',
                  icon: const Icon(Icons.person_outline),
                  onTap: () => Get.to(const ProfileEditView()),
                ),
                const Divider(thickness: 0.1),

                Obx(() {
                  final roleId = meController.profile.value?.user?.roleId;
                  if (roleId == '64971752-2b59-4a4e-b742-ecb337e3b386') {
                    return Column(
                      children: [
                        ProfileListTile(
                          title: 'Setting',
                          icon: const Icon(Icons.settings_outlined),
                          onTap: () => Get.to(const MultiStepSekolahView()),
                        ),
                        const Divider(thickness: 0.1),
                        ProfileListTile(
                          title: 'Report Absen',
                          icon: const Icon(Icons.payment_outlined),
                          onTap: () => Get.to(AllAttendanceView()),
                        ),
                        const Divider(thickness: 0.1),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                }),

                const Divider(thickness: 0.1),

                ProfileListTile(
                  title: 'Logout',
                  icon: const Icon(Icons.logout),
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
