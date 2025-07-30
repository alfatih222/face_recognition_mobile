// ignore_for_file: unused_local_variable

import 'package:facerecognition/views/faceDetection/face.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/components/widgets/button_bar.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final bool sudahAbsen = false; // Ubah ke true/false sesuai status absen
  final String namaPengguna = "Harits";
  final String jenisAbsen = "Masuk";

  late Timer _timer;
  late DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tanggal = now.toDateDay(); // Format: "Sabtu, 26 Juli 2025"
    final jam = now.toTime(); // Format: "14:32"
    final jamBerjalan = DateFormat.Hms().format(now); // Format: "14:32:07"

    return Scaffold(
      appBar: getAppBar(title: "Home"),
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
          const SizedBox(height: 40),

          // Body
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!sudahAbsen) ...[
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
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
                        onPressed: () {
                          final result = Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FaceScannerScreen(),
                            ),
                          );
                        },
                        title: "Gunakan Face ID",
                        iconData: Icons.face,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
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
                        children: const [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Check in",
                                style: TextStyle(color: Colors.green),
                              ),
                              Text("9:00am"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Check out",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              Text("11:00am"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
