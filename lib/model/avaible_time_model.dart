class AvaibleTimeModel {
  String? dateId;
  List<Times>? times;

  AvaibleTimeModel({this.dateId, this.times});

  AvaibleTimeModel.fromJson(Map<String, dynamic> json) {
    dateId = json['date_id'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        times!.add(Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date_id'] = dateId;
    if (times != null) {
      data['times'] = times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  String? id;
  String? time;
  bool? isAvailable;

  Times({this.id, this.time, this.isAvailable});

  Times.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['time'] = time;
    data['is_available'] = isAvailable;
    return data;
  }
}
