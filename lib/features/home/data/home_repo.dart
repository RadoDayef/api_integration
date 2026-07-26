import 'package:api_integration/core/network/response_result.dart';
import 'package:api_integration/features/home/data/models/article_model.dart';

class HomeRepo {
  Future<ResponseResult<List<ArticleModel>>> getArticles() async {
    try {
      List articlesData = [];
      List<ArticleModel> articles = articlesData.map((article) => ArticleModel.fromJson(article)).toList();
      return SuccessResponse(articles);
    } catch (exception, stackTrack) {
      return FailureResponse(exception.toString(), stackTrack);
    }
  }
}
