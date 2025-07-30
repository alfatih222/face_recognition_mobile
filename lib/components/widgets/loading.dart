// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Widget nextPage;
  final Duration duration;

  const LoadingScreen({
    super.key,
    required this.nextPage,
    this.duration = const Duration(seconds: 3), // Default 3 detik
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(widget.duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.nextPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            CircularProgressIndicator(),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            CircularProgressIndicator(strokeWidth: 4),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}
