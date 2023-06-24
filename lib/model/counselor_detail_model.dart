class CounselorDetailModel {
  String? id;
  String? profilePicture;
  String? username;
  String? name;
  String? topic;
  num? price;
  num? rating;
  String? description;

  CounselorDetailModel({
    this.id,
    this.profilePicture,
    this.username,
    this.name,
    this.topic,
    this.price,
    this.rating,
    this.description,
  });

  CounselorDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profile_picture'];
    username = json['username'];
    name = json['name'];
    topic = json['topic'];
    price = json['price'];
    rating = json['rating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'profile_picture': profilePicture,
        'username': username,
        'name': name,
        'topic': topic,
        'price': price,
        'rating': rating,
        'description': description,
      };
}
