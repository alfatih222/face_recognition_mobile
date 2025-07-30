import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OSearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  Function(String)? onSubmit;

   OSearchWidget(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.hintText,
      this.onSubmit})
      : super(key: key);

  @override
  State<OSearchWidget> createState() => _OSearchWidgetState();
}

class _OSearchWidgetState extends State<OSearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.black);
    const styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
        height: 42,
        width: 400,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black26),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: TextField(
          controller: controller,
          onSubmitted: widget.onSubmit,
          decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: style.color,
            ),
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: style.color,
                    ),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ));
  }
}
