import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: color ?? OprimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      // color: Theme.of(context).primaryColor,
    );

    return (loading)
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: onPressed,
            child: SizedBox(
              width: double.infinity,
              height: 75,
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
