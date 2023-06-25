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
    image = json['image'];
  }
}
