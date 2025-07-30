import 'package:facerecognition/components/base/dialog.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AlertCustom extends StatelessWidget {
  AlertCustom({
    required this.title,
    required this.massage,
    this.textOne,
    required this.textTwo,
    this.textColorOne,
    this.textColorTwo,
    this.backgroundColorOne,
    this.backgroundColorTwo,
    required this.onPressedOne,
    required this.onPressedTwo,
    super.key,
  });

  String title;
  String massage;
  String? textOne;
  Color? textColorOne;
  Color? backgroundColorOne;
  final Function() onPressedOne;
  String textTwo;
  Color? textColorTwo;
  Color? backgroundColorTwo;
  final Function() onPressedTwo;

  @override
  Widget build(BuildContext context) {
    return getDialog(
      title: title,
      message: massage,
      actions: [
        DialogTextButton(
          text: textOne ?? "Batalkan",
          textColor: textColorOne ?? OprimaryColor,
          backgroundColor: backgroundColorOne ?? const Color(0xffDCE2F9),
          // isLoading: controller.isLoading.value,
          onPressed: onPressedOne,
        ),
        const SizedBox(width: 12),
        DialogTextButton(
          text: textTwo,
          textColor: textColorTwo ?? const Color(0xffDCE2F9),
          backgroundColor: backgroundColorTwo ?? OprimaryColor,
          // isLoading: controller.isLoading.value,
          onPressed: onPressedTwo,
        ),
      ],
    );
  }
}
