import 'package:intl/intl.dart';

class MoneyFormatter {
  String formatRupiah(int price) {
    final formatter = NumberFormat("#,###");
    return "Rp. ${formatter.format(price)}";
  }
}
