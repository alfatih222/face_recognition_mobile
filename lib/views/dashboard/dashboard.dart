// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:facerecognition/components/widgets/alertx.dart';
import 'package:facerecognition/controllers/absence_controller.dart';
import 'package:facerecognition/controllers/user_controller.dart';
import 'package:facerecognition/models/absen_model.dart';
import 'package:facerecognition/views/faceDetection/face.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/components/widgets/button_bar.dart';
import 'package:facerecognition/utils/colors.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final RxBool sudahAbsen = false.obs;
  final Alertx alert = Alertx();
  late Timer _timer;
  late DateTime now;

  final MeController meController = Get.put(MeController());
  final GetAbsenController getAbsenController = Get.put(GetAbsenController());

  @override
  void initState() {
    super.initState();
    now = DateTime.now();

    // Timer untuk update jam berjalan realtime
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });

    // Ambil data user dan absensi awal
    meController.fetchMe().then((_) {
      final userId = meController.profile.value?.user?.id;
      if (userId != null) {
        getAbsenController.fetchAbsensByUser(userId);
      }
    });

    // Listener untuk absens, supaya sudahAbsen otomatis update saat absens berubah
    ever<List<Attendance>>(getAbsenController.absens, (absens) {
      print(['sdsdsdd', absens]);
      sudahAbsen.value = absens.isNotEmpty;
      print(['sdsdsdd', sudahAbsen.value]);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tanggal = now.toDateDay();
    final jamBerjalan = DateFormat.Hms().format(now);

    return Scaffold(
      appBar: getAppBar(title: "Home"),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: ListView(
        children: [
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
          const SizedBox(height: 40),

          // Body
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                final profile = meController.profile.value;
                final user = profile?.user;

                if (meController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (profile == null || user == null) {
                  return const Text("Data pengguna tidak tersedia").black();
                }

                return Column(
                  children: [
                    Text(
                      "Selamat datang, ${profile.fullname}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${user.role?.name ?? '-'}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }),

              Obx(() {
                if (!sudahAbsen.value) {
                  // BELUM ABSEN
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Absen dengan Face ID").blue().title(),
                        const SizedBox(height: 12),
                        Image.asset(
                          "assets/images/face.png",
                          width: 60.w,
                          height: 30.h,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Mohon letakkan ponsel Anda di depan wajah Anda",
                          textAlign: TextAlign.center,
                        ).black(),
                        const SizedBox(height: 20),
                        CButton(
                          onPressed: () async {
                            final result = await Get.to(() => FaceCameraPage());
                            if (result != null) {
                              final bool allow = result['allow'];
                              final String message = result['message'];

                              if (allow) {
                                alert.success(message);
                                final userId =
                                    meController.profile.value?.user?.id;
                                if (userId != null) {
                                  await getAbsenController.fetchAbsensByUser(
                                    userId,
                                  );
                                  // sudahAbsen akan otomatis update via ever
                                }
                              } else {
                                alert.error(message);
                              }
                            }
                          },
                          title: "Gunakan Face ID",
                          iconData: Icons.face,
                        ),
                      ],
                    ),
                  );
                } else {
                  // SUDAH ABSEN - tampilkan check in/out
                  if (getAbsenController.absens.isEmpty) {
                    // Safety fallback kalau tiba2 kosong
                    return const SizedBox();
                  }

                  final attendance = getAbsenController.absens[0];
                  final checkIn = attendance.checkIn ?? "-";
                  final checkOut = attendance.checkOut ?? "-";

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 60,
                        ),
                        const SizedBox(height: 12),
                        const Text("Anda sudah absen").black().title(),
                        const Text("di lingkungan sekolah").black(),
                        const SizedBox(height: 8),
                        Text(
                          jamBerjalan,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Check in",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text(checkIn),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Check out",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                Text(checkOut),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
              const SizedBox(height: 20),
              Obx(() {
                if (sudahAbsen.value) {
                  return CButton(
                    onPressed: () async {
                      final result = await Get.to(() => FaceCameraPage());
                      if (result != null) {
                        final bool allow = result['allow'];
                        final String message = result['message'];

                        if (allow) {
                          alert.success(message);
                          final userId = meController.profile.value?.user?.id;
                          if (userId != null) {
                            await getAbsenController.fetchAbsensByUser(userId);
                            // sudahAbsen akan otomatis update via ever
                          }
                        } else {
                          alert.error(message);
                        }
                      }
                    },
                    title: "Gunakan Face ID",
                    iconData: Icons.face,
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}
