class SignupModel {
  late String name;
  late String email;
  late String username;
  late String password;

  SignupModel({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
  });

  SignupModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    email = map['email'];
    username = map['username'];
    password = map['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
