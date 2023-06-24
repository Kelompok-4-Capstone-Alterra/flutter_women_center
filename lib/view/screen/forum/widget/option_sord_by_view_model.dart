import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OptionSortByViewModel extends ChangeNotifier {
  String? selectedSortBy;
  String? url;

  void setSelectedSortBy(String option) {
    selectedSortBy = option;
    notifyListeners();
  }

  Future<void> joinForum(url) async {
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
