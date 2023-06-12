import 'package:capstone_project/model/user_model.dart';
import 'package:dio/dio.dart';

import '../api/endpoint.dart';
import '../api/interceptor_api.dart';

class UserService extends InterceptorApi {
  Future<UserModel> getProfile(String token) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.userProfile;
      var response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final profile = UserModel.fromJson(response.data);
      return profile;
    } catch (e) {
      rethrow;
    }
  }
}
