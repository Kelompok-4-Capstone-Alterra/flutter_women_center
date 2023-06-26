import 'package:intl/intl.dart';

class ArticlesMock {
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

  ArticlesMock({
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

  ArticlesMock.fromJson(Map<String, dynamic> json) {
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

class CounselorMock {
  String? id;
  String? profilePicture;
  String? name;
  String? topic;
  int? price;
  double? rating;

  CounselorMock(
      {this.id,
      this.profilePicture,
      this.name,
      this.topic,
      this.price,
      this.rating});

  CounselorMock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profile_picture'];
    name = json['name'];
    topic = json['topic'];
    price = json['price'];
    rating = double.parse(json['rating'].toString());
  }
}

class CareerMock {
  String? id;
  String? image;
  String? jobPosition;
  String? companyName;
  String? location;
  int? salary;
  String? companyEmail;

  CareerMock(
      {this.id,
      this.image,
      this.jobPosition,
      this.companyName,
      this.location,
      this.salary,
      this.companyEmail});

  CareerMock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    jobPosition = json['job_position'];
    companyName = json['company_name'];
    location = json['location'];
    salary = json['salary'];
    companyEmail = json['company_email'];
  }
}
