import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final TextEditingController? controller;
  final bool obscureText;
  final String? title;
  final Color? color;
  final double? size;
  final IconData? icon;
  final Widget? prefix, suffix;
  final void Function(String)? onChange;
  final bool readOnly;

  // ignore: use_key_in_widget_constructors
  const CTextField({
    required this.hint,
    this.title,
    this.icon,
    this.color,
    this.size,
    required this.inputType,
    this.controller,
    this.prefix,
    this.suffix,
    this.onChange,
    this.obscureText = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (title != null)
            ? Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      (icon != null)
                          ? Icon(
                              icon,
                              size: size ?? 20,
                              color: color ?? OprimaryColor,
                            )
                          : Container(),
                      const SizedBox(width: 8),
                      Text(title!).regularBigText().blue(),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              )
            : Container(),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: TextField(
            style: const TextStyle(fontSize: 14),
            onChanged: onChange,
            obscureText: obscureText,
            keyboardType: inputType,
            readOnly: readOnly,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 18,
                right: 18,
                top: 16,
                bottom: 16,
              ),
              prefixIcon: prefix,
              suffixIcon: suffix,
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 14),
              border: InputBorder.none,
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }
}

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final Function()? onTap;
  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.3),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    cursorColor: OprimaryColor,
                    // style: vrsmltitleStyle,
                    onTap: onTap,
                    decoration: InputDecoration(
                      hintText: hint,
                      // hintStyle: vrsmltitleStyleGrey,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
