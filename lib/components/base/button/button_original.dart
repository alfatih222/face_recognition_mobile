import 'package:flutter/material.dart';

class ButtonAccent extends StatelessWidget {
  final String title;
  final String? image;
  final Function() onPressed;
  final Color? color;
  final Color? colorText;
  final bool loading;
  // ignore: use_key_in_widget_constructors
  const ButtonAccent(this.title,
      {required this.onPressed,
      this.color,
      this.image,
      this.colorText,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => (loading)
            ? () {
                return;
              }
            : onPressed(),
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            foregroundColor: const Color(0xFF5964FF),
            backgroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))
                ),
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: (loading)
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Text(title,
                    style: TextStyle(
                        color: colorText,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)))
                );
  }
}
