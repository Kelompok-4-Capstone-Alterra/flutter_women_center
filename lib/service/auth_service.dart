import 'package:capstone_project/service/api/endpoint.dart';
import 'package:capstone_project/service/api/interceptor_api.dart';
import 'package:capstone_project/model/login_model.dart';
import 'package:capstone_project/model/signup_model.dart';

class AuthService extends InterceptorApi {
  Future<String> checkUsernameEmail({
    required String email,
    required String username,
  }) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.checkUsernameEmail;
      final response = await dio.post(
        url,
        data: {
          'email': email,
          'username': username,
        },
      );
      return response.data["meta"]["message"].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verify({required String email}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.verify;
      final response = await dio.post(
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

  Future<String> login({required LoginModel loginData}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.login;
      final response = await dio.post(
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

  Future<String> register({required SignupModel registerData}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.register;
      final response = await dio.post(
        url,
        data: registerData.toJson(),
      );
      final String message = response.data["meta"]["message"].toString();
      return message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> requestOtpForgotPassword({required String email}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.requestOptForgotPassword;
      final response = await dio.post(
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

  Future<String> requestNewPassword(
      {required String email, required String otp}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.requestNewPassword;
      final response = await dio.post(
        url,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      return response.data["meta"]["message"].toString();
    } catch (e) {
      rethrow;
    }
  }
}
