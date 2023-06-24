import 'package:capstone_project/model/user_model.dart';
import 'package:dio/dio.dart';

import '../api/endpoint.dart';
import '../api/interceptor_api.dart';

class UserService extends InterceptorApi {
  Future<UserModel> getProfile(String token) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.userProfile;
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final profile = UserModel.fromJson(response.data['data']['profile']);
      return profile;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateProfile(String token, UserModel userData) async {
    const String url = Endpoint.baseUrl + Endpoint.userProfile;
    final FormData putData = await userData.toFormData();
    try {
      final response = await dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          contentType:
              'multipart/form-data; boundary=<calculated when request is sent>',
        ),
        data: putData,
      );
      return response.data["meta"]["message"].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> changePassword(
      String token, String currentPassword, String newPassword) async {
    const String url = Endpoint.baseUrl + Endpoint.userChangePassword;
    try {
      final response = await dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
      return response.data["meta"]["message"].toString();
    } catch (e) {
      rethrow;
    }
  }
}
