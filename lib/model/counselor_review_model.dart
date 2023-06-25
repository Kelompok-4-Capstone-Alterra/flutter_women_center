class CounselorReviewModel {
  int? currentPage;
  List<Reviews>? reviews;
  int? totalPage;

  CounselorReviewModel({
    this.currentPage,
    this.reviews,
    this.totalPage,
  });

  CounselorReviewModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_pages'];
    totalPage = json['total_pages'];
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['current_pages'] = currentPage;
    data['total_pages'] = totalPage;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? id;
  String? userProfile;
  String? username;
  num? rating;
  String? review;
  String? createdAt;

  Reviews({
    this.id,
    this.userProfile,
    this.username,
    this.rating,
    this.review,
    this.createdAt,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userProfile = json['user_profile'];
    username = json['username'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_profile'] = userProfile;
    data['username'] = username;
    data['rating'] = rating;
    data['review'] = review;
    data['created_at'] = createdAt;
    return data;
  }
}
