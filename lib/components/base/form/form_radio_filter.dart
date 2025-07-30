import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OMyRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const OMyRadioOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  });

  Widget _buildLabel(BuildContext context) {
    final bool isSelected = value == groupValue;
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: isSelected
          ? SvgPicture.asset("assets/ic/ic_white_tick.svg")
          : Container(),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    ).titleText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Row(
          children: [
            _buildLabel(context),
            const SizedBox(width: 10),
            _buildText(context),
          ],
        ),
      ),
    );
  }
}
