import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OSquareCheckBox extends StatelessWidget {
  final Function(bool?)? fungsi;
  final bool accept;
  final String text;
  final Color? color;
  Widget? child;
  OSquareCheckBox({
    Key? key,
    required this.fungsi,
    required this.accept,
    required this.text,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Theme.of(context).colorScheme.onPrimary,
      activeColor: (color == null)
          ? Theme.of(context).colorScheme.primary
          : color,
      title: (child != null)
          ? child
          : Text(
              text,
              style: const TextStyle(color: Colors.black),
            ).regularText(),
      value: accept,
      onChanged: fungsi,
    );
  }
}
