// ignore_for_file: deprecated_member_use

import 'package:facerecognition/controllers/absence_controller.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class FaceCameraPage extends StatefulWidget {
  @override
  _FaceCameraPageState createState() => _FaceCameraPageState();
}

class _FaceCameraPageState extends State<FaceCameraPage> {
  late List<CameraDescription> cameras;
  CameraController? controller;
  final AbsenceController absenceController = Get.put(AbsenceController());

  bool isProcessing = false;
  String message = 'Mempersiapkan kamera...';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
      controller = CameraController(frontCamera, ResolutionPreset.medium);
      await controller!.initialize();

      if (!mounted) return;

      setState(() {
        message = 'Kamera siap, mengambil gambar dalam 2 detik...';
      });

      await Future.delayed(const Duration(seconds: 2));
      await _captureAndUpload();
    } catch (e) {
      setState(() {
        message = 'Gagal inisialisasi kamera: $e';
      });
    }
  }

  Future<void> _captureAndUpload() async {
    if (controller == null || !controller!.value.isInitialized || isProcessing)
      return;

    setState(() {
      isProcessing = true;
      message = 'Mengambil gambar...';
    });

    try {
      final XFile picture = await controller!.takePicture();

      setState(() {
        message = 'Mengambil lokasi...';
      });

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        message = 'Mengirim data ke server...';
      });

      bool success = await absenceController.createAbsence(picture, {
        'lat': position.latitude,
        'lng': position.longitude,
      });

      Navigator.pop(
        context,
        success ? 'Absensi berhasil!' : 'Absensi gagal, coba lagi.',
      );
    } catch (e) {
      Navigator.pop(context, 'Terjadi kesalahan: $e');
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('Absensi Wajah')),
        body: Center(child: Text(message)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Wajah')),
      body: Stack(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: CameraPreview(controller!),
              ),
              const SizedBox(height: 20),
              Center(child: Text(message)),
            ],
          ),
          if (isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Sedang mengirim data ke server...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
