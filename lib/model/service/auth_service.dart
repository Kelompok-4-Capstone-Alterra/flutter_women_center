import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/login_model.dart';
import 'package:capstone_project/model/signup_model.dart';

class AuthService extends InterceptorApi {
  Future<String> verify(String email) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.verify;
      var response = await dio.post(
        url,
        data: {
          'email': email,
        },
      );
      return response.data["meta"]["message"].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login(LoginModel loginData) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.login;
      var response = await dio.post(
        url,
        data: {
          'username': loginData.username,
          'password': loginData.password,
        },
      );
      final String token = response.data["data"]["token"].toString();
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> register(SignupModel registerData) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.register;
      var response = await dio.post(
        url,
        data: registerData.toJson(),
      );
      final String message = response.data["meta"]["message"].toString();
      return message;
    } catch (e) {
      rethrow;
    }
  }
}
