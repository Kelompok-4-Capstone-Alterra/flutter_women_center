class TransactionsOngoingModel {
  String? id;
  String? link;
  String? timeStart;
  String? consultationMethod;
  CounselorDataModel? counselorData;

  TransactionsOngoingModel({
    this.id,
    this.link,
    this.timeStart,
    this.consultationMethod,
    this.counselorData,
  });

  TransactionsOngoingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    timeStart = json['time_start'];
    consultationMethod = json['consultation_method'];
    counselorData = json['counselor_data'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['time_start'] = timeStart;
    data['consultation_method'] = consultationMethod;
    data['counselor_data'] = counselorData;
    return data;
  }
}

class CounselorDataModel {
  String? id;
  String? profilePicture;
  String? name;
  String? topic;
  int? price;

  CounselorDataModel({
    this.id,
    this.profilePicture,
    this.name,
    this.topic,
    this.price,
  });

  CounselorDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profile_picture'];
    name = json['name'];
    topic = json['topic'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_picture'] = profilePicture;
    data['name'] = name;
    data['topic'] = topic;
    data['price'] = price;
    return data;
  }
}
