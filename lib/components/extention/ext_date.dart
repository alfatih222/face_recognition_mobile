// ignore_for_file: unnecessary_this

import 'package:dart_date/dart_date.dart';

String localRegion = 'id_ID';

extension DatetimeExt on DateTime {
  DateTime checkUtc() {
    if (this.isUtc) return this.toLocal();
    return this;
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  String toDateHuman() {
    DateTime res = checkUtc();
    return res.format('dd MMMM y');
  }

  String toDateTime() {
    DateTime res = checkUtc();
    return res.format('dd MMM y, HH:mm', localRegion);
  }

  String toDateShortMonth() {
    DateTime res = checkUtc();
    return res.format('dd MMM y', localRegion);
  }

  String toDateShort() {
    DateTime res = checkUtc();
    return res.format('dd MMM y', localRegion);
  }

  String toTime() {
    DateTime res = checkUtc();
    return res.format('HH:mm', localRegion);
  }

  String toDate2() {
    DateTime res = checkUtc();
    return res.format('y-MM-dd', localRegion);
  }

  String toyyyyMMdd() {
    DateTime res = checkUtc();
    return res.format('yyyy-MM-dd', localRegion);
  }

  String toDateNotif() {
    DateTime res = checkUtc();
    return res.format('y-MM-dd HH:mm', localRegion);
  }

  String toDateDay() {
    DateTime res = checkUtc();
    return res.format('EEEE, dd MMMM y', localRegion);
  }
}
