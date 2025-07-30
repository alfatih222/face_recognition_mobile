import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OButtonSmallOutline extends StatefulWidget {
  final String title;
  final String icon;
  final Color? titleColor;
  final Function()? onTap;
  const OButtonSmallOutline({
    Key? key,
    required this.title,
    required this.icon,
    this.titleColor,
    this.onTap,
  }) : super(key: key);

  @override
  State<OButtonSmallOutline> createState() => _OButtonSmallOutlineState();
}

class _OButtonSmallOutlineState extends State<OButtonSmallOutline> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 104,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color:
                    widget.titleColor ??
                    Theme.of(context).colorScheme.onPrimary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SvgPicture.asset(widget.icon),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        widget.titleColor ??
                        Theme.of(context).colorScheme.onPrimary,
                  ),
                ).fieldTitleText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChoosePlaceButton extends StatefulWidget {
  const ChoosePlaceButton({super.key});

  @override
  State<ChoosePlaceButton> createState() => _ChoosePlaceButtonState();
}

class _ChoosePlaceButtonState extends State<ChoosePlaceButton> {
  // late String placeValue = "Jakarta";
  // final cBooking = Get.find<BookingController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _navigateAndDisplaySelection(context);
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            style: BorderStyle.solid,
            width: 0.80,
          ),
        ),
        child: Obx(
          () => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              // cBooking.selectRegion.value,
              "",
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _navigateAndDisplaySelection(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => RegionListPage()),
  //   );
  //   // setState(() {
  //   //   placeValue = result.name;
  //   // });
  //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$result')));
  //   // print(placeValue);
  //   // print(result);
  // }
}
