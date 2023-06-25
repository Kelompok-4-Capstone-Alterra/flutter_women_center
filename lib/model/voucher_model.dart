class VoucherModel {
  String? id;
  String? userId;
  String? expDate;
  num? value;
  String? createdAt;

  VoucherModel({
    this.id,
    this.userId,
    this.expDate,
    this.value,
    this.createdAt,
  });

  VoucherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    expDate = json['exp_date'];
    value = json['value'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['exp_date'] = expDate;
    data['value'] = value;
    data['created_at'] = createdAt;
    return data;
  }
}
