class TransactionDetailModel {
  Meta? meta;
  Data? data;

  TransactionDetailModel({this.meta, this.data});

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Meta {
  String? message;
  int? status;

  Meta({this.message, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Data {
  String? dateId;
  String? timeId;
  String? id;
  String? userId;
  String? counselorId;
  CounselorData? counselorData;
  String? link;
  String? timeStart;
  String? consultationMethod;
  String? status;
  int? valueVoucher;
  int? grossPrice;
  int? totalPrice;
  bool? isReviewed;
  String? createdAt;

  Data(
      {this.dateId,
      this.timeId,
      this.id,
      this.userId,
      this.counselorId,
      this.counselorData,
      this.link,
      this.timeStart,
      this.consultationMethod,
      this.status,
      this.valueVoucher,
      this.grossPrice,
      this.totalPrice,
      this.isReviewed,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    dateId = json['date_id'];
    timeId = json['time_id'];
    id = json['id'];
    userId = json['user_id'];
    counselorId = json['counselor_id'];
    counselorData = json['counselor_data'] != null
        ? CounselorData.fromJson(json['counselor_data'])
        : null;
    link = json['link'];
    timeStart = json['time_start'];
    consultationMethod = json['consultation_method'];
    status = json['status'];
    valueVoucher = json['value_voucher'];
    grossPrice = json['gross_price'];
    totalPrice = json['total_price'];
    isReviewed = json['is_reviewed'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_id'] = dateId;
    data['time_id'] = timeId;
    data['id'] = id;
    data['user_id'] = userId;
    data['counselor_id'] = counselorId;
    if (counselorData != null) {
      data['counselor_data'] = counselorData!.toJson();
    }
    data['link'] = link;
    data['time_start'] = timeStart;
    data['consultation_method'] = consultationMethod;
    data['status'] = status;
    data['value_voucher'] = valueVoucher;
    data['gross_price'] = grossPrice;
    data['total_price'] = totalPrice;
    data['is_reviewed'] = isReviewed;
    data['created_at'] = createdAt;
    return data;
  }
}

class CounselorData {
  String? id;
  String? profilePicture;
  String? username;
  String? name;
  String? email;
  String? topic;
  int? price;
  int? rating;
  String? description;

  CounselorData({
    this.id,
    this.profilePicture,
    this.username,
    this.name,
    this.email,
    this.topic,
    this.price,
    this.rating,
    this.description,
  });

  CounselorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profile_picture'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    topic = json['topic'];
    price = json['price'];
    rating = json['rating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_picture'] = profilePicture;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['topic'] = topic;
    data['price'] = price;
    data['rating'] = rating;
    data['description'] = description;

    return data;
  }
}
