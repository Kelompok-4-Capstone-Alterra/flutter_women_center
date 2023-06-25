class DetailCareerModel {
  late String? id;
  late String? image;
  late String? jobPosition;
  late String? companyName;
  late String? location;
  late int? salary;
  late String? companyEmail;
  late int? minExperience;
  late String? lastEducation;
  late String? description;
  late String? createdAt;
  late String? jobType;

  DetailCareerModel({
    this.id,
    this.image,
    this.jobPosition,
    this.companyName,
    this.location,
    this.salary,
    this.companyEmail,
    this.minExperience,
    this.lastEducation,
    this.description,
    this.createdAt,
    this.jobType,
  });

  DetailCareerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    jobPosition = json["job_position"];
    companyName = json["company_name"];
    location = json["location"];
    salary = json["salary"];
    companyEmail = json["company_email"];
    minExperience = json["min_experience"];
    lastEducation = json["last_education"];
    description = json["description"];
    createdAt = json["created_at"];
    jobType = json["job_type"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["image"] = image;
    data["job_position"] = jobPosition;
    data["company_name"] = companyName;
    data["location"] = location;
    data["salary"] = salary;
    data["company_email"] = companyEmail;
    data["min_experience"] = minExperience;
    data["last_education"] = lastEducation;
    data["description"] = description;
    data["created_at"] = createdAt;
    return data;
  }
}
