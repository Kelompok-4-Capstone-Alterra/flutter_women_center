import 'package:intl/intl.dart';

class Articles {
  int? id;
  String title;
  String author;
  String date;
  String image;
  String category;
  String desc;

  Articles({
    required this.title,
    required this.author,
    required this.date,
    required this.desc,
    required this.category,
    required this.image,
  });

  String get formattedDate {
    final parsedDate = DateTime.parse(date);
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(parsedDate);
  }
}
