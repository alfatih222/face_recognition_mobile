import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';

class ORadio<T> extends StatelessWidget {
  const ORadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final T groupValue;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<T>(
              groupValue: groupValue,
              activeColor: Theme.of(context).colorScheme.primary,
              value: value,
              onChanged: (T? newValue) {
                onChanged(newValue as T);
              },
            ),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ).titleText(),
          ],
        ),
      ),
    );
  }
}
