import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';

class OButtonOVal extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  final bool loading;
  final bool isEnable;
  const OButtonOVal({
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
    // final gstate = Get.put(GlobalController());

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: color ?? const Color(primaryDark),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // color: Theme.of(context).primaryColor,
    );
    final ButtonStyle flatButtonStyleDisable = TextButton.styleFrom(
      backgroundColor: const Color(greyLight),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // color: Theme.of(context).primaryColor,
    );

    return (loading)
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: onPressed,
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton(
                style: isEnable ? flatButtonStyle : flatButtonStyleDisable,
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
