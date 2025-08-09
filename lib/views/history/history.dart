// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:facerecognition/components/widgets/absenPreview.dart';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/controllers/absence_controller.dart';
import 'package:facerecognition/controllers/user_controller.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final GetAbsenController absenController = Get.put(GetAbsenController());
  final MeController meController = Get.put(MeController());

  @override
  void initState() {
    super.initState();
    // Pastikan profile user sudah ada
    meController.fetchMe().then((_) {
      final userId = meController.profile.value?.user?.id;
      if (userId != null) {
        absenController.fetchAbsensByUser(userId, type: "all");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "History"),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: Obx(() {
        if (absenController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (absenController.absens.isEmpty) {
          return const Center(child: Text('Tidak ada data absensi.'));
        }

        return ListView(
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
            const SizedBox(height: 20),
            ...absenController.absens.map((absen) {
              final checkIn = absen.checkIn ?? '';
              final checkOut = absen.checkOut ?? '';
              final status = (checkIn.isNotEmpty && checkOut.isNotEmpty)
                  ? AbsenStatus.hadir
                  : AbsenStatus.belumLengkap;

              return AbsenPreviewTile(
                clockInTime: checkIn,
                checkOutTime: checkOut,
                date: absen.date,
                status: status,
                onTap: () {},
              );
            }).toList(),
          ],
        );
      }),
    );
  }
}
