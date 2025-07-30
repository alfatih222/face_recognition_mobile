// ignore_for_file: use_super_parameters

import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: const Text("Page Title - Nunito Bold 14").pageTitleText(),
    );
  }
}

AppBar getAppBar({
  String title = "",
  Widget? widgetTitle,
  List<Widget>? actions,
  BuildContext? context,
  automaticallyImplyLeading = true,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
    backgroundColor: OprimaryColor,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   // Status bar color
    //   statusBarColor: OprimaryColor,
    //   systemNavigationBarColor: OprimaryColor,
    //   systemNavigationBarIconBrightness: Brightness.light,
    //   // Status bar brightness (optional)
    //   statusBarIconBrightness: Brightness.light, // For Android (dark icons)
    //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
    // ),
    // foregroundColor: Colors.amber,
    centerTitle: true,
    actions: actions,
    elevation: 0,
    title: (widgetTitle != null)
        ? widgetTitle
        : Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
  );
}

AppBar getNoAppBar({
  String title = "",
  Widget? widgetTitle,
  List<Widget>? actions,
  BuildContext? context,
  automaticallyImplyLeading = true,
}) {
  return AppBar(
    toolbarHeight: 0,
    automaticallyImplyLeading: automaticallyImplyLeading,
    iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
    backgroundColor: OprimaryColor,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   // Status bar color
    //   statusBarColor: OprimaryColor,
    //   systemNavigationBarColor: OprimaryColor,
    //   systemNavigationBarIconBrightness: Brightness.light,
    //   // Status bar brightness (optional)
    //   statusBarIconBrightness: Brightness.light, // For Android (dark icons)
    //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
    // ),
    // foregroundColor: Colors.amber,
    centerTitle: true,
    actions: actions,
    elevation: 0,
    title: (widgetTitle != null)
        ? widgetTitle
        : Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
  );
}
