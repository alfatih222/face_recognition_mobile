import 'package:facerecognition/components/base/button/button.dart';
import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../constant.dart';

class Alertx {
  // final gstate = Get.find<GlobalController>();
  success(String? message, {String title = 'Success', String code = ''}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          height: 200,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Icon(Icons.check, size: 50, color: Colors.green),
                const SizedBox(height: 10),
                Text(title),
                // const SizedBox(height: 10),
                Text(message ?? ''),
                const SizedBox(height: 20),
                Expanded(
                  child: OButton(
                    title: 'OK',
                    color: Colors.green,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog({
    String title = '',
    desc = '',
    required Function() onPressForNo,
    required Function() onPressForYes,
  }) async {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Text(title).titleText(),
                const SizedBox(height: 10),
                Text(desc),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: onPressForNo,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: const Text('Tidak'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: OButton(title: 'Ya', onPressed: onPressForYes),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loading() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const SizedBox(
          height: 100,
          width: 50,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  error(String? message, {String title = 'Oops...', String code = ''}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          height: 280,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Icon(Icons.error, size: 80, color: Colors.orange),
                const SizedBox(height: 10),
                Text(title).titleText(),
                const SizedBox(height: 10),
                Text(
                  message ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                OButton(
                  title: 'OK',
                  onPressed: () {
                    if (code == 'UNAUTHENTICATED') {
                      // gstate.token = '';
                      // Get.offAll(OnBoardingPage());
                    } else {
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
