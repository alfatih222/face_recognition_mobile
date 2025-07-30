import 'package:flutter/material.dart';

bottomSheetWidget(
    {required BuildContext context,
    required Widget child,
    double heightFactor = 0.9}) async {
  await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: heightFactor,
          // widthFactor: gstate.widthFactor,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0))),
                    child: child)),
          ),
        );
      });
}
