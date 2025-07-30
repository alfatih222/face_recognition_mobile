// ignore_for_file: deprecated_member_use

import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';

extension TextExtension on Text {
  Text gray() => copyWith(style: const TextStyle(color: Color(0xff99A4AB)));
  Text titleText() => copyWith(
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  );
  Text regularBigText() => copyWith(
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  );
  Text regularText() => copyWith(
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  );
  Text descriptionText() => copyWith(
    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  );
  Text descriptionBigText() => copyWith(
    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
  );
  Text pageTitleText() => copyWith(
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  );
  Text fieldTitleText() => copyWith(
    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
  );
  Text linkText() => copyWith(
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Color(0xff2D79F6),
    ),
  );
  Text informationText() => copyWith(
    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
  );

  Text blue() => copyWith(style: TextStyle(color: OprimaryColor));
  Text white() => copyWith(style: const TextStyle(color: Colors.white));
  Text grey() => copyWith(style: const TextStyle(color: Color(0xffE7E7E7)));
  Text grey2() => copyWith(style: const TextStyle(color: Color(0xff99A4AB)));
  Text black() => copyWith(style: const TextStyle(color: Colors.black));
  Text red() => copyWith(style: const TextStyle(color: Colors.red));
  Text brown() => copyWith(style: const TextStyle(color: Colors.brown));
  Text title() => copyWith(
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  );

  Text copyWith({
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection = TextDirection.ltr,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextStyle? style,
  }) {
    return Text(
      data ?? '',
      key: key ?? this.key,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      style: style != null ? this.style?.merge(style) ?? style : this.style,
    );
  }
}
