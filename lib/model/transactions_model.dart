class TransactionsModel {
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

  TransactionsModel(
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

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    dateId = json['date_id'] ?? '-';
    timeId = json['time_id'] ?? '-';
    id = json['id'] ?? '-';
    userId = json['user_id'] ?? '-';
    counselorId = json['counselor_id'] ?? '-';
    counselorData = json['counselor_data'] != null
        ? CounselorData.fromJson(json['counselor_data'])
        : CounselorData();
    link = json['link'] ?? '-';
    timeStart = json['time_start'] ?? '-';
    consultationMethod = json['consultation_method'] ?? '-';
    status = json['status'] ?? '-';
    valueVoucher = json['value_voucher'] ?? 0;
    grossPrice = json['gross_price'] ?? 0;
    totalPrice = json['total_price'] ?? 0;
    isReviewed = json['is_reviewed'] ?? false;
    createdAt = json['created_at'] ?? '-';
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
  String? reviews;
  String? dates;
  String? times;
  String? deletedAt;
  String? createdAt;
  String? transactions;

  CounselorData(
      {this.id,
      this.profilePicture,
      this.username,
      this.name,
      this.email,
      this.topic,
      this.price,
      this.rating,
      this.description,
      this.reviews,
      this.dates,
      this.times,
      this.deletedAt,
      this.createdAt,
      this.transactions});

  CounselorData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '-';
    profilePicture = json['profile_picture'] ?? '-';
    username = json['username'] ?? '-';
    name = json['name'] ?? '-';
    email = json['email'] ?? '-';
    topic = json['topic'] ?? '-';
    price = json['price'] ?? 0;
    rating = json['rating'] ?? 3;
    description = json['description'] ?? '-';
    reviews = json['reviews'] ?? '-';
    dates = json['dates'] ?? '-';
    times = json['times'] ?? '-';
    deletedAt = json['deleted_at'] ?? '-';
    createdAt = json['created_at'] ?? '-';
    transactions = json['transactions'] ?? '-';
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
    data['reviews'] = reviews;
    data['dates'] = dates;
    data['times'] = times;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['transactions'] = transactions;
    return data;
  }
}
