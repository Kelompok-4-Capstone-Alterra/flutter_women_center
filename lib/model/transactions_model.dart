class TransactionsModel {
  String? id;
  String? userId;
  String? dateId;
  String? timeId;
  String? counselorId;
  String? link;
  String? timeStart;
  String? consultationMethod;
  String? status;
  bool? isReviewed;
  String? createdAt;
  int? totalPrice;
  CounselorModel? counselorData;

  TransactionsModel({
    this.id,
    this.userId,
    this.dateId,
    this.timeId,
    this.counselorId,
    this.link,
    this.timeStart,
    this.consultationMethod,
    this.status,
    this.isReviewed,
    this.createdAt,
    this.counselorData,
    this.totalPrice,
  });

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    dateId = json['date_id'];
    timeId = json['time_id'];
    counselorId = json['counselor_id'];
    link = json['link'];
    timeStart = json['time_start'];
    consultationMethod = json['consultation_method'];
    status = json['status'];
    isReviewed = json['is_reviewed'];
    createdAt = json['created_at'];
    totalPrice = json['total_price'];
    counselorData = CounselorModel.fromJson(json['counselor_data']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['date_id'] = dateId;
    data['time_id'] = timeId;
    data['counselor_id'] = counselorId;
    data['link'] = link;
    data['time_start'] = timeStart;
    data['consultation_method'] = consultationMethod;
    data['status'] = status;
    data['is_reviewed'] = isReviewed;
    data['created_at'] = createdAt;
    data['total_price'] = totalPrice;
    data['counselor_data'] = counselorData;
    return data;
  }
}

class CounselorModel {
  String? id;
  String? profilePicture;
  String? name;
  String? email;
  String? topic;

  CounselorModel({
    this.id,
    this.profilePicture,
    this.name,
    this.email,
    this.topic,
  });

  CounselorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profile_picture'];
    name = json['name'];
    email = json['email'];
    topic = json['topic'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_picture'] = profilePicture;
    data['name'] = name;
    data['email'] = email;
    data['topic'] = topic;
    return data;
  }
}
