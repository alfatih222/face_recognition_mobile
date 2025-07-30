import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';

class ODropdown extends StatefulWidget {
  final String title;
  final List<String> itemDropdown;
  final String dropdownValue;
  final ValueChanged<String> onChanged;
  const ODropdown({
    Key? key,
    required this.itemDropdown,
    required this.dropdownValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  State<ODropdown> createState() => _ODropdownState();
}

class _ODropdownState extends State<ODropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Text(
          widget.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ).grey(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: widget.dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 16),
            underline: Container(height: 2, color: const Color(0xffE7E7E7)),
            onChanged: (String? newValue) {
              widget.onChanged(newValue!);
            },
            items: widget.itemDropdown.map<DropdownMenuItem<String>>((
              String value,
            ) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
