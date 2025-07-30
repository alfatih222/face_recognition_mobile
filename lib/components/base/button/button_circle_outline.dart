import 'package:flutter/material.dart';

class OCircleButtonOutline extends StatelessWidget {
  final String? title;
  final String? icon;
  final Function()? onTap;
  final Color? color;
  final Color? iconColor;
  final Color? outlineColor;
  final bool loading;
  const OCircleButtonOutline({
    Key? key,
    this.title,
    this.onTap,
    required this.icon,
    this.loading = false,
    this.color,
    this.iconColor,
    this.outlineColor
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return (loading)
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                // color: (iconColor != null) ? Theme.of(context).colorScheme.onPrimary : iconColor  ,
                border: Border.all(
                  width: 2,
                  color: iconColor ?? Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              width: 48,
              height: 48,
              child: ClipOval(
                child: Material(
                  color:  Theme.of(context).colorScheme.onPrimary,
                  child: InkWell(
                    splashColor: Colors.red, // Splash color
                    onTap: () {},
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: (icon == null)
                          ? Container()
                          : (icon == null)
                              ? Container()
                              : Icon(
                                  Icons.menu,
                                  color: (iconColor == null) ? Theme.of(context).colorScheme.primary : iconColor,
                                ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 5),
                    //     child:
                    //     SvgPicture.asset(icon!),
                    // ),
                  ),
                ),
              ),
            ),
          );
  }
}
