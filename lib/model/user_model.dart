import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  String? picturePath;
  PlatformFile? pictureFile;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.picturePath,
    this.pictureFile,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone_number'];
    picturePath = json['profile_picture'];
  }

  Future<FormData> toFormData() async {
    final FormData data = FormData.fromMap(
      {
        if (name != null) 'name': name,
        if (username != null) 'username': username,
        if (phone != null) 'phone_number': phone,
        if (pictureFile != null)
          'profile_picture': await MultipartFile.fromFile(pictureFile!.path!,
              filename: pictureFile!.name),
      },
    );
    return data;
  }
}
