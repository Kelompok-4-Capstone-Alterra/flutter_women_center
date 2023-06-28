class SignupModel {
  String? name;
  String? email;
  String? username;
  String? password;
  String? otp;

  SignupModel({
    this.name,
    this.email,
    this.username,
    this.password,
    this.otp,
  });

  SignupModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    data['otp'] = otp;
    return data;
  }
}
