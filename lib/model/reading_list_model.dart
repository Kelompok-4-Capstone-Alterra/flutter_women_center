class ReadingListModel {
  String? id;
  String? userId;
  String? name;
  String? description;
  int? articleTotal;
  String? createdAt;
  List<ReadingListArticlesModel>? readingListArticles;
  ReadingListModel({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.articleTotal,
    this.createdAt,
    this.readingListArticles,
  });

  ReadingListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    articleTotal = json['article_total'];
    createdAt = json['created_at'];
    if (readingListArticles != null) {
      readingListArticles = [
        ReadingListArticlesModel.fromJson(json['reading_list_articles'])
      ];
    }
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['description'] = description;
    data['article_total'] = articleTotal;
    data['created_at'] = createdAt;
    if (readingListArticles != null) {
      for (var element in readingListArticles!) {
        data['reading_list_articles'] = element;
      }
    }
    return data;
  }
}

class ReadingListArticlesModel {
  String? id;
  ArticleModel? article;
  ReadingListArticlesModel({
    this.id,
    this.article,
  });

  ReadingListArticlesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    article = ArticleModel.fromJson(json['article']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['article'] = article;
    return data;
  }
}

class ArticleModel {
  String? id;
  String? image;
  String? title;
  String? author;
  String? category;
  ArticleModel({
    this.id,
    this.image,
    this.title,
    this.author,
    this.category,
  });
  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    author = json['author'];
    category = json['category'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['author'] = author;
    data['category'] = category;
    return data;
  }
}
