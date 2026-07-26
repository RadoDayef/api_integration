import 'package:api_integration/features/home/data/models/article_source_model.dart';

class ArticleModel {
  DateTime publishedAt;
  ArticleSourceModel source;
  String url, title, author, content, urlToImage, description;

  ArticleModel({
    required this.url,
    required this.title,
    required this.author,
    required this.source,
    required this.content,
    required this.urlToImage,
    required this.publishedAt,
    required this.description,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      url: json["url"] ?? "",
      title: json["title"] ?? "",
      author: json["author"] ?? "",
      content: json["content"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      description: json["description"] ?? "",
      source: ArticleSourceModel.fromJson(json["source"]),
      publishedAt: json["publishedAt"] == null ? DateTime.now() : DateTime.parse(json["publishedAt"]),
    );
  }
}
