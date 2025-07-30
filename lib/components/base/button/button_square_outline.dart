import 'package:flutter/material.dart';

class OButtonSquareOutline extends StatelessWidget {
  final String? title;
  final String? icon;
  final Function()? onTap;
  final Color? color;
  final Color? iconColor;
  final bool loading;
  const OButtonSquareOutline({
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
              border: Border.all(
                color: iconColor ?? Theme.of(context).colorScheme.primary, 
                width: 2),
              color: 
              Theme.of(context).colorScheme.onPrimary,
            ),
              width: 48,
              height: 48,
              child: InkWell(
                // splashColor: Theme.of(context).colorScheme.onPrimary,
                onTap: () {},
                child: 
                (icon == null)
                    ? Container()
                    : (icon == null)
                        ? Container()
                        : Icon(
                            Icons.menu,
                            color: (iconColor == null) ? Theme.of(context).colorScheme.primary : iconColor,
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
