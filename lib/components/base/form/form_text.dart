import 'package:facerecognition/components/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum FormType { text, email, phone, password, money }

class OBaseFormText extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final bool isRequired;
  final FormType formType;
  final int maxLines;
  final bool readOnly;

  const OBaseFormText({
    Key? key,
    required this.title,
    this.controller,
    this.isRequired = true,
    this.formType = FormType.text,
    this.hintText,
    this.maxLines = 1,
    this.readOnly = false,
  }) : super(key: key);

  String? checkValidation(String value) {
    if (isRequired) {
      if (value.isEmpty) {
        return '${title.toUpperCase()} TIDAK BOLEH KOSONG';
      }
    }
    if (formType == FormType.phone) {
      if (int.tryParse(value) == null) {
        return '${title.toUpperCase()} HANYA ANGKA SAJA';
      }
    }
    if (formType == FormType.email) {
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (value.trim().isNotEmpty && !regex.hasMatch(value.trim())) {
        return '${title.toUpperCase()} HARUS VALID EMAIL';
      }
    }
    return null;
  }

  List<TextInputFormatter>? maskFormat(FormType type) {
    if (type == FormType.phone) {
      return [
        MaskTextInputFormatter(
          mask: '#### #### #### ##',
          filter: {"#": RegExp(r'[0-9]')},
        ),
      ];
    } else if (type == FormType.money) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final obscureText = false.obs;
    if (formType == FormType.password) obscureText.value = true;
    return Column(
      children: [
        Obx(
          () => TextFormField(
            readOnly: readOnly,
            maxLines: maxLines,
            validator: (value) => checkValidation(value!),
            controller: controller,
            keyboardType:
                (formType == FormType.phone || formType == FormType.money)
                ? TextInputType.number
                : TextInputType.text,
            // inputFormatters: maskFormat(formType),
            decoration: InputDecoration(
              border: InputBorder.none,
              // border: InputBorder.none,
              hintText: hintText ?? 'Masukkan ${title.capitalizeText()}',
              // hintStyle: TextStyle(fontSize: gstate.bodyTextSize)
              suffixIcon: (formType == FormType.password)
                  ? InkWell(
                      child: Icon(
                        (obscureText.value)
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onTap: () => obscureText.value = !obscureText.value,
                    )
                  : const SizedBox.shrink(),
            ),
            obscureText: obscureText.value,
          ),
        ),
        // const SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }
}
