import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BaseButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Color? color;
  final Color? textColor;
  final Function() ontap;
  final String? image;
  final String? iconSvg;
  final Color? outlineColor;
  final double? outlineRadius;
  final double? height;
  final double? width;
  const BaseButton({
    Key? key,
    this.icon,
    this.text,
    this.color,
    required this.ontap,
    this.textColor,
    this.image,
    this.iconSvg,
    this.outlineColor,
    this.outlineRadius,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height == null) ? 48 : height,
      width: (height == null) ? Get.width : width,
      decoration: BoxDecoration(
        color: (color == null) ? const Color(0xff2D79F6) : color,
        borderRadius: BorderRadius.circular(
          (outlineRadius == null) ? 8 : outlineRadius!,
        ),
        border: Border.all(
          color: (outlineColor == null) ? Colors.transparent : outlineColor!,
        ),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: ontap,
          child: Center(
            child: (icon == null && image == null && iconSvg == null)
                ? Text(
                    text!,
                    style: TextStyle(
                      color: (textColor == null) ? Colors.white : textColor,
                    ),
                  ).pageTitleText()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (image == null) ...[
                        if (iconSvg == null) ...[
                          Icon(icon),
                        ] else ...[
                          SvgPicture.asset(iconSvg!),
                        ],
                      ] else ...[
                        Image.asset(image!, width: 24, height: 24),
                      ],
                      const SizedBox(width: 8),
                      (textColor == null)
                          ? Text(text!).pageTitleText().white()
                          : Text(text!, style: TextStyle(color: textColor)),
                      // .pageTitleText()
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
