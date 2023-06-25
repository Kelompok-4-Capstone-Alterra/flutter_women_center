class TopicModel {
  int? id;
  String? name;
  String? image;

  TopicModel({
    this.id,
    this.name,
    this.image,
  });

  TopicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
