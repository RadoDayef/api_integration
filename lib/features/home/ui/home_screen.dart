import 'package:api_integration/core/network/response_result.dart';
import 'package:api_integration/core/theming/theming_colors.dart';
import 'package:api_integration/core/utils/num_extensions.dart';
import 'package:api_integration/features/home/data/home_repo.dart';
import 'package:api_integration/features/home/data/models/article_model.dart';
import 'package:api_integration/features/home/data/models/tab_model.dart';
import 'package:api_integration/features/home/ui/widgets/article_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String error = "";
  int categoryPage = 1;
  bool isLoading = true;
  String category = "sports";
  List<ArticleModel> articles = [];
  ScrollController scrollController = ScrollController();

  void onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
      fetchArticles(page: categoryPage);
    }
  }

  @override
  void initState() {
    fetchArticles();
    super.initState();
    scrollController.addListener(onScroll);
  }

  void fetchArticles({int page = 1}) async {
    setState(() {
      error = "";
      isLoading = true;
      if (page == 1) articles.clear();
    });
    ResponseResult<List<ArticleModel>> result = await HomeRepo().getArticles(category, page: page, pageSize: 5);
    if (result is SuccessResponse<List<ArticleModel>>) {
      setState(() {
        articles.addAll(result.data);
        categoryPage++;
        isLoading = false;
      });
    } else {
      setState(() {
        error = (result as FailureResponse<List<ArticleModel>>).error;
        print(error);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TabModel> tabs = [
      TabModel(Icons.sports, name: "Sports", category: "sports"),
      TabModel(Icons.cases, name: "Business", category: "business"),
      TabModel(Icons.science, name: "Science", category: "science"),
      TabModel(Icons.laptop, name: "Technology", category: "technology"),
      TabModel(Icons.all_inclusive, name: "General", category: "general"),
      TabModel(Icons.add, name: "Entertainment", category: "entertainment"),
      TabModel(Icons.health_and_safety, name: "Health", category: "health"),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemingColors.primaryColor,
          foregroundColor: ThemingColors.whiteColor,
          centerTitle: true,
          title: Text("Easy News"),
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.search)],
          bottom: TabBar(
            onTap: (int index) {
              setState(() {
                category = tabs[index].category;
                categoryPage = 1;
                fetchArticles();
              });
            },
            padding: .all(0),
            isScrollable: true,
            unselectedLabelColor: ThemingColors.whiteColor.withAlpha(100),
            labelColor: ThemingColors.whiteColor,
            tabs: tabs.map((tab) => Column(children: [Icon(tab.icon), 4.vGap, Text(tab.name), 6.vGap])).toList(),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: ThemingColors.primaryColor))
            : error.isNotEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: ThemingColors.primaryColor, size: 50),
                    Text("Something went wrong", style: TextStyle(color: ThemingColors.primaryColor, fontSize: 20)),
                  ],
                ),
              )
            : TabBarView(
                children: tabs.map((tab) {
                  return ListView.separated(
                    padding: .all(16),
                    itemCount: articles.length,
                    controller: scrollController,
                    itemBuilder: (_, int index) {
                      ArticleModel article = articles[index];
                      return ArticleWidget(article);
                    },
                    separatorBuilder: (_, _) {
                      return 16.vGap;
                    },
                  );
                }).toList(),
              ),
      ),
    );
  }
}
