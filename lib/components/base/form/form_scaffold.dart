import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';

class OScaffold extends StatelessWidget {
  final Color backgroundColor;
  final Widget body;
  final bool isRounded;
  final Widget? bottomNavigationBar;
  final String? title;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const OScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.isRounded = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    // final gstate = Get.find<GlobalController>();
    RoundedRectangleBorder rounded = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      // resizeToAvoidBottomInset: true,
      // Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: OprimaryColor,
        // Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        // bottom: PreferredSizeWidget(),
        title: Text(title ?? '').pageTitleText(),
        elevation: 0,
        actions: actions,
        shape: isRounded ? rounded : null,
        // toolbarHeight: gstate.toolbarHeight,
      ),
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
