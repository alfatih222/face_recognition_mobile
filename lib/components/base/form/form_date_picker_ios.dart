import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OdatePickeriOS extends StatefulWidget {
  final String title;
  DateTime? date;
  final Function(DateTime) onChanged;
  OdatePickeriOS({
    Key? key,
    required this.title,
    this.date,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<OdatePickeriOS> createState() => _OdatePickeriOSState();
}

class _OdatePickeriOSState extends State<OdatePickeriOS> {
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
            color: Theme.of(context).colorScheme.primary,
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
                    _showIOS_DatePicker(context);
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
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    hintText: 'Masukkan ${widget.title.capitalizeText()}',
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ignore: unused_element
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
    }
  }

  // ignore: non_constant_identifier_names
  void _showIOS_DatePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 190,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: widget.date,
                onDateTimeChanged: (val) {
                  setState(() {
                    widget.date = val;
                  });
                  widget.onChanged(val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
