class ReadingListModel {
  String? id;
  String? userId;
  String? name;
  String? description;
  int? articleTotal;
  String? createdAt;
  List<ReadingListArticles>? readingListArticles;

  ReadingListModel(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.articleTotal,
      this.createdAt,
      this.readingListArticles});

  ReadingListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '-';
    userId = json['user_id'] ?? '-';
    name = json['name'] ?? '-';
    description = json['description'] ?? '-';
    articleTotal = json['article_total'] ?? 0;
    createdAt = json['created_at'] ?? '';
    if (json['reading_list_articles'] != null) {
      readingListArticles = <ReadingListArticles>[];
      json['reading_list_articles'].forEach((v) {
        readingListArticles!.add(ReadingListArticles.fromJson(v));
      });
    } else {
      readingListArticles = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['description'] = description;
    data['article_total'] = articleTotal;
    data['created_at'] = createdAt;
    if (readingListArticles != null) {
      data['reading_list_articles'] =
          readingListArticles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReadingListArticles {
  String? id;
  Article? article;

  ReadingListArticles({this.id, this.article});

  ReadingListArticles.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '-';
    article =
        json['article'] != null ? Article.fromJson(json['article']) : Article();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (article != null) {
      data['article'] = article!.toJson();
    }
    return data;
  }
}

class Article {
  String? id;
  String? image;
  String? title;
  String? author;
  String? category;

  Article({this.id, this.image, this.title, this.author, this.category});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '-';
    image = json['image'] ?? '-';
    title = json['title'] ?? '-';
    author = json['author'] ?? '-';
    category = json['category'] ?? '-';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['author'] = author;
    data['category'] = category;
    return data;
  }
}
