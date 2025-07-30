import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OdatePickerAndroid extends StatefulWidget {
  final String title;
  DateTime? date;
  final Color? titleColor;
  final Function(DateTime) onChanged;

  OdatePickerAndroid({
    Key? key,
    this.titleColor,
    required this.title,
    required this.date,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<OdatePickerAndroid> createState() => _OdatePickerAndroidState();
}

class _OdatePickerAndroidState extends State<OdatePickerAndroid> {
  //init date

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: (widget.titleColor == null)
                ? const Color(0xffE7E7E7)
                : widget.titleColor,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          // onTap: fungsi,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  validator: (baseValidator) {
                    if (baseValidator == null || baseValidator.isEmpty) {
                      return '${widget.title.toUpperCase()} TIDAK BOLEH KOSONG';
                    }
                    return null;
                  },
                  controller: TextEditingController(
                    text: widget.date?.toDateHuman() ?? '',
                  ),
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    prefixIcon: const Icon(Icons.date_range_rounded),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                    hintText: 'Masukkan ${widget.title.capitalizeText()}',
                  ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.date ?? DateTime.now(),
      firstDate: DateTime(1980, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.date) {
      setState(() {
        widget.date = picked;
      });
      widget.onChanged(picked);
    }
  }
}
