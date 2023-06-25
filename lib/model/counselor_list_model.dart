class CounselorListModel {
  String? id;
  String? profilePicture;
  String? name;
  String? topic;
  num? price;
  num? rating;

  CounselorListModel({
    this.id,
    this.profilePicture,
    this.name,
    this.topic,
    this.price,
    this.rating,
  });

  CounselorListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profile_picture'];
    name = json['name'];
    topic = json['topic'];
    price = json['price'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'profile_picture': profilePicture,
        'name': name,
        'topic': topic,
        'price': price,
        'rating': rating,
      };
}
