import 'package:api_integration/core/theming/theming_colors.dart';
import 'package:api_integration/core/utils/num_extensions.dart';
import 'package:api_integration/features/home/data/models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleModel article;

  const ArticleWidget(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        borderRadius: .circular(24),
        border: .all(color: ThemingColors.primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: .circular(24),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage,
                progressIndicatorBuilder: (_, _, _) => CircularProgressIndicator(color: ThemingColors.primaryColor),
                errorWidget: (_, _, _) => Icon(Icons.image_rounded, size: 75),
              ),
            ),
          ),
          16.vGap,
          Text(
            article.title,
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(fontSize: 20, color: ThemingColors.primaryColor, fontWeight: .bold),
          ),
          8.vGap,
          Text(
            article.content,
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(fontSize: 14, color: ThemingColors.primaryColor.withAlpha(150)),
          ),
          8.vGap,
          Text(
            "Author: ${article.author}",
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(fontSize: 14, color: ThemingColors.redColor, fontWeight: .bold),
          ),
          Text(
            "Source: ${article.source.name}",
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(fontSize: 14, color: ThemingColors.greenColor, fontWeight: .bold),
          ),
          Text(
            "Published At: ${DateFormat.yMMMMd().format(article.publishedAt)}",
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(fontSize: 14, color: ThemingColors.blueColor, fontWeight: .bold),
          ),
        ],
      ),
    );
  }
}
