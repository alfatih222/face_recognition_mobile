import 'package:flutter/material.dart';
import 'package:facerecognition/utils/colors.dart';

class CSelectField<T> extends StatelessWidget {
  final String title;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final IconData? icon;

  const CSelectField({
    Key? key,
    required this.title,
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            if (icon != null) Icon(icon, size: 20, color: OprimaryColor),
            if (icon != null) const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<T>(
            isExpanded: true,
            value: value,
            items: items,
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '',
              contentPadding: EdgeInsets.zero,
            ),
            hint: Text(hint),
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }
}
