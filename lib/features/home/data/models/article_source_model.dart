class ArticleSourceModel {
  String? id;
  String name;

  ArticleSourceModel({required this.id, required this.name});

  factory ArticleSourceModel.fromJson(Map<String, dynamic> json) {
    return ArticleSourceModel(id: json["id"], name: json["name"] ?? "");
  }
}
