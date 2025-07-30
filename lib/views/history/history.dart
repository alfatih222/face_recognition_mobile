import 'package:facerecognition/components/widgets/absenPreview.dart';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "History"),
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
          const SizedBox(height: 20),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
          AbsenPreviewTile(
            clockInTime: '08:00',
            date: '25 Juli 2025',
            status: AbsenStatus.hadir,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
