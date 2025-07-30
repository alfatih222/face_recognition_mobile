import 'package:flutter/material.dart';
import 'package:get/get.dart';

getDialog(
    {required String title,
    String message = "",
    required List<Widget> actions,
    bool isVertical = false,
    bool isBarrierDismissable = false}) {
  Get.dialog(
      Dialog(
        insetAnimationDuration: const Duration(milliseconds: 0),
        insetAnimationCurve: Curves.ease,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900),
              ),
              (message.isNotEmpty)
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          message,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 18,
              ),
              const Divider(
                height: 0,
              ),
              const SizedBox(
                height: 18,
              ),
              (isVertical)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: actions,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: actions,
                    )
            ],
          ),
        ),
      ),
      barrierDismissible: isBarrierDismissable);
}

// ignore_for_file: use_key_in_widget_constructors
class DialogTextButton extends StatelessWidget {
  final Color textColor, backgroundColor;
  final String text;
  final Function() onPressed;
  final bool isVertical;
  final bool isLoading;

  const DialogTextButton(
      {required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.onPressed,
      this.isVertical = false,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return (!isVertical)
        ? Expanded(
            child: _TextButtonContent(
              onPressed: onPressed,
              text: text,
              textColor: textColor,
              backgroundColor: backgroundColor,
              isLoading: isLoading,
            ),
          )
        : Row(
            children: [
              Expanded(
                child: _TextButtonContent(
                  onPressed: onPressed,
                  text: text,
                  textColor: textColor,
                  backgroundColor: backgroundColor,
                  isLoading: isLoading,
                ),
              ),
            ],
          );
  }
}

class _TextButtonContent extends StatelessWidget {
  const _TextButtonContent(
      {required this.onPressed,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.isLoading});

  final Function() onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (isLoading) ? onPressed : onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              (!isLoading) ? backgroundColor : Colors.grey.shade50)),
      child: Text(text,
          style: TextStyle(
              color: (!isLoading) ? textColor : Colors.grey, fontSize: 14)),
    );
  }
}
