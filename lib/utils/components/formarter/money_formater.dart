import 'package:intl/intl.dart';

class MoneyFormatter {
  String formatRupiah(num price) {
    final formatter = NumberFormat("#,###");
    return "Rp. ${formatter.format(price)}";
  }
}
