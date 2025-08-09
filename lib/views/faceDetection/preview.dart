import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;
  XFile? _capturedFile;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    cameras = await availableCameras();

    // Cari kamera depan
    final frontCamera = cameras!.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras!.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (!mounted) return;

    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) return;

    if (_controller!.value.isTakingPicture) return;

    try {
      XFile file = await _controller!.takePicture();

      setState(() {
        _capturedFile = file;
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void _retakePicture() {
    setState(() {
      _capturedFile = null;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Ambil Foto")),
      body: _capturedFile == null ? _buildCameraPreview() : _buildPreview(),
    );
  }

  Widget _buildCameraPreview() {
    return Stack(
      children: [
        CameraPreview(_controller!),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Center(
            child: FloatingActionButton(
              onPressed: _takePicture,
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Column(
      children: [
        Expanded(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Image.file(File(_capturedFile!.path), fit: BoxFit.contain),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _retakePicture,
              child: const Text("Ambil Ulang"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, File(_capturedFile!.path));
              },
              child: const Text("Gunakan Foto"),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
