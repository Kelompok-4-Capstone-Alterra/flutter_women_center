class UserModel {
  String? id;
  String? name;
  String? email;
  String? username;
  String? phone;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['phone'] = phone;
    return data;
  }
}
