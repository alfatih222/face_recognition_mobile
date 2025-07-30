import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OCheckBox extends StatelessWidget {
  final Function(bool?)? fungsi;
  final bool accept;
  final String text;
  Widget? child;
  OCheckBox({
    Key? key,
    required this.fungsi,
    required this.accept,
    required this.text,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          checkColor: Theme.of(context).colorScheme.onPrimary,
          activeColor: Theme.of(context).colorScheme.primary,
          value: accept,
          onChanged: fungsi,
        ),
        Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ).titleText(),
      ],
    );
  }
}
