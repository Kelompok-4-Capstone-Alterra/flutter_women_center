import 'package:intl/intl.dart';

class Articles {
  String? id;
  String? image;
  String? title;
  String? author;
  String? topic;
  int? viewCount;
  int? commentCount;
  String? description;
  String? date;
  bool? saved;

  Articles({
    this.id,
    this.image,
    this.title,
    this.author,
    this.topic,
    this.viewCount,
    this.commentCount,
    this.description,
    this.date,
    this.saved,
  });

  Articles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    author = json['author'];
    topic = json['topic'];
    viewCount = json['viewCount'];
    commentCount = json['commentCount'];
    description = json['description'];
    date = json['date'];
    saved = json['saved'];
  }

  String get formattedDate {
    final parsedDate = DateTime.parse(date!);
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(parsedDate);
  }
}
