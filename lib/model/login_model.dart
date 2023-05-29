class LoginModel {
  late String username;
  late String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  LoginModel.fromJson(Map<String, dynamic> map) {
    username = map['username'];
    password = map['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
