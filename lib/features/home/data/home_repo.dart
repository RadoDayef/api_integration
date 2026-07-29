import 'package:api_integration/core/network/end_points.dart';
import 'package:api_integration/core/network/response_result.dart';
import 'package:api_integration/features/home/data/models/article_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  final Dio dio = Dio();

  Future<ResponseResult<List<ArticleModel>>> getArticles(String category) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get("${EndPoints.topHeadlines}?category=$category&${EndPoints.apiKey}");
      List articlesData = response.data!["articles"];
      List<ArticleModel> articles = articlesData.map((article) => ArticleModel.fromJson(article)).toList();
      return SuccessResponse(articles);
    } catch (exception, stackTrack) {
      return FailureResponse(exception.toString(), stackTrack);
    }
  }
}
