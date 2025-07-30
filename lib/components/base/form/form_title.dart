import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';

class OTitleHeader extends StatelessWidget {
  final String title;
  const OTitleHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(title).pageTitleText(),
          ),
        ),
      ],
    );
  }
}
