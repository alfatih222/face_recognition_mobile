import 'package:flutter/material.dart';

class ButtonChoosePlace extends StatefulWidget {
  final String placeValue;
  final Function() onTap;

  const ButtonChoosePlace({Key? key, required this.placeValue, required this.onTap}) : super(key: key);

  @override
  State<ButtonChoosePlace> createState() => _ButtonChoosePlaceState();
}

class _ButtonChoosePlaceState extends State<ButtonChoosePlace> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 24,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Theme.of(context).colorScheme.secondary, style: BorderStyle.solid, width: 0.80),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 7.0, top: 1),
          child: Text(
            widget.placeValue,
          ),
        ),
      ),
    );
  }
}
