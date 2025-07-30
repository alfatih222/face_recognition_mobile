// import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';

class OButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  final bool loading;
  const OButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: Material(
                borderRadius: BorderRadius.circular(8),
                color: (color == null) ? const Color(0xff043C95) : color,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onPressed,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (icon == null)
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: icon,
                              ),
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
            ),
          );
  }
}
