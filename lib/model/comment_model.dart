import 'package:intl/intl.dart';

class Comment {
  String? id;
  String? articleId;
  String? userId;
  String? profilePicture;
  String? username;
  String? comment;
  String? createdAt;

  Comment({
    this.id,
    this.articleId,
    this.userId,
    this.profilePicture,
    this.username,
    this.comment,
    this.createdAt,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    articleId = json['articleId'];
    userId = json['user_id'];
    profilePicture = json['profile_picture'];
    username = json['username'];
    comment = json['comment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['articleId'] = articleId;
    data['user_id'] = userId;
    data['profile_picture'] = profilePicture;
    data['username'] = username;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    return data;
  }

  String get formattedCreatedDate {
    final parsedDate = DateTime.parse(createdAt!);
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(parsedDate);
  }
}
