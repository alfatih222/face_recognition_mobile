import 'package:facerecognition/components/base/loading_custom.dart';
import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OButtonBar extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  final bool loading;
  final bool isEnable;
  const OButtonBar({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.isEnable = true,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: color ?? Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    );
    return (loading)
        ? const CLoading()
        : GestureDetector(
            onTap: onPressed,
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton(
                style: (isEnable)
                    ? flatButtonStyle
                    : TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        // color: Theme.of(context).primaryColor,
                      ),
                onPressed: (isEnable) ? onPressed : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (icon == null)
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(width: 30, height: 30, child: icon),
                          ),
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor ?? Colors.white,
                        ),
                      ).titleText(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

// ignore: must_be_immutable
class CButton extends StatelessWidget {
  CButton({
    this.iconColor,
    this.iconSize,
    this.iconData,
    this.height,
    this.titleColor,
    this.titleSize,
    this.horizontal,
    this.backgroundColor,
    this.circular,
    this.titleWeight,
    this.isActive,
    this.isVerified,
    required this.onPressed,
    required this.title,
    super.key,
  });

  Function() onPressed;
  String title;
  Color? titleColor;
  double? titleSize;
  FontWeight? titleWeight;
  IconData? iconData;
  Color? iconColor;
  double? iconSize;
  double? height;
  Color? backgroundColor;
  double? horizontal;
  double? circular;
  bool? isActive;
  bool? isVerified;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 8.w),
      child: SizedBox(
        height: height ?? 38,
        width: double.infinity,
        child: ElevatedButton(
          // onPressed: (isActive ?? true) ? onPressed : null,
          onPressed: (isVerified ?? false)
              ? () {
                  Get.snackbar(
                    'Berhasil Validasi',
                    'data sudah berhasil validasi',
                  );
                }
              : (isActive ?? true)
              ? onPressed
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: (isVerified == true)
                ? const Color(0xffF6F9FC)
                : backgroundColor ?? const Color(0xff9DB9EC),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circular ?? 24.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (iconData != null || isVerified == true)
                  ? Row(
                      children: [
                        Icon(
                          (isVerified == true) ? Icons.check : iconData,
                          size: iconSize ?? 22,
                          color: (isVerified == true)
                              ? Colors.green
                              : iconColor ?? OprimaryColor,
                        ),
                        const SizedBox(width: 12),
                      ],
                    )
                  : Container(),
              Text(
                title,
                style: TextStyle(
                  color: (isActive == false)
                      ? const Color(0xff9B9898)
                      : titleColor ?? OprimaryColor,
                  fontWeight: titleWeight ?? FontWeight.bold,
                  fontSize: titleSize ?? 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
