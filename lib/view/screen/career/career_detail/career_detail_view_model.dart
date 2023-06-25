import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../model/detail_career_model.dart';
import '../../../../../model/service/career_service.dart';
import '../../../../../utils/state/finite_state.dart';

class DetailCareerViewModel extends ChangeNotifier {
  String? selectedSortBy;
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  final CareerService _careerService = CareerService();
  DetailCareerModel _detailCareer = DetailCareerModel();

  MyState get state => _state;
  DetailCareerModel get detailCareerList => _detailCareer;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _loginData.containsKey('token') &&
        _loginData.getString('token')!.isNotEmpty;
  }

  String getCurrentDate({required String date}) {
    final parse = DateTime.parse(date);
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(parse);
  }

  Future<void> fetchCareerById({required String id}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';

      _detailCareer = await _careerService.getCareerById(token: token, id: id);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
    notifyListeners();
  }

  Future<void> getApplyCareer(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Subjek "Nama_Posisi"',
      },
    );
    final String url = emailLaunchUri.toString();
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
    notifyListeners();
  }
}
