import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/key/naviagtor_key.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/my_color.dart';

class InterceptorApi {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  InterceptorApi() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response!.statusCode == 401) {
            showDialog(
              context: navigatorKey.currentContext!,
              builder: (context) {
                return AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 90),
                  surfaceTintColor: MyColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(color: MyColor.neutralLow, width: .5),
                  ),
                  title:
                      Icon(Icons.sms_failed, color: MyColor.danger, size: 50),
                  content: Text(
                    'Session Expired',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MyColor.neutralHigh, fontSize: 12),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeScreen.routeName, (route) => false);
                        final loginData = await SharedPreferences.getInstance();
                        loginData.remove('token');
                        return handler.next(e);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: MyColor.primaryMain,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            final messageError =
                e.response!.data['meta']['message'] ?? 'Something went wrong';
            showDialog(
              context: navigatorKey.currentContext!,
              builder: (context) {
                return AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 90),
                  surfaceTintColor: MyColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(color: MyColor.neutralLow, width: .5),
                  ),
                  title:
                      Icon(Icons.sms_failed, color: MyColor.danger, size: 50),
                  content: Text(
                    messageError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MyColor.neutralHigh, fontSize: 12),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        return handler.next(e);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: MyColor.primaryMain,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
    _dio.options.headers['Content-Type'] = 'application/json';
  }
}
