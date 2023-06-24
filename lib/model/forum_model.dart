import 'package:capstone_project/model/user_model.dart';

class ForumModel {
  String? id;
  String? userId;
  UserModel? user;
  String? category;
  int? categoryId;
  String? link;
  String? topic;
  bool? status;
  int? member;
  String? createdAt;

  ForumModel(
      {this.id,
      this.userId,
      this.user,
      this.category,
      this.categoryId,
      this.link,
      this.topic,
      this.status,
      this.member,
      this.createdAt});

  ForumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    category = json['category'];
    link = json['link'];
    topic = json['topic'];
    status = json['status'];
    member = json['member'];
    createdAt = json['created_at'];
    user = UserModel(
      name: json['user']['name'],
      picturePath: json['user']['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['link'] = link;
    data['topic'] = topic;
    return data;
  }
}
