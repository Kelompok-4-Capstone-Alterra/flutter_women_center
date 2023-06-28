class CareerModel {
  late String? id;
  late String? image;
  late String? jobPosition;
  late String? companyName;
  late String? location;
  late int? salary;

  CareerModel({
    this.id,
    this.image,
    this.jobPosition,
    this.companyName,
    this.location,
    this.salary,
  });

  CareerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    jobPosition = json["job_position"];
    companyName = json["company_name"];
    location = json["location"];
    salary = json["salary"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "job_position": jobPosition,
        "company_name": companyName,
        "location": location,
        "salary": salary,
      };
}
