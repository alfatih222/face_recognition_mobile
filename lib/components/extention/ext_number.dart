// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension CurrencyExt on num {
  String toCurrency() {
    final formatter = NumberFormat("#,###", 'IDR');
    return 'Rp ${formatter.format(this)}';
  }
}
