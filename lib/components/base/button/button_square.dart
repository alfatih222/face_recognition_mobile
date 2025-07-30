import 'package:flutter/material.dart';

class OButtonSquare extends StatelessWidget {
  final String? title;
  final String? icon;
  final Function()? onTap;
  final Color? color;
  final Color? iconColor;
  final bool loading;
  const OButtonSquare({
    Key? key,
    this.title,
    this.onTap,
    required this.icon,
    this.loading = false,
    this.color,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (color == null) ? Theme.of(context).colorScheme.primary : color,
            ),
              width: 48,
              height: 48,
              child: InkWell(
                splashColor: Colors.red, // Splash color
                onTap: () {},
                child: 
                (icon == null)
                    ? Container()
                    : (icon == null)
                        ? Container()
                        : Icon(
                            Icons.menu,
                            color: (iconColor == null) ? Theme.of(context).colorScheme.onPrimary : iconColor,
                          ),
                // Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 5),
                //     child:
                //     SvgPicture.asset(icon!),
                // ),
              ),
            ),
        );
  }
}
