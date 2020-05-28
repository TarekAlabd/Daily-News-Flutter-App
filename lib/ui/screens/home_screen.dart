import 'package:flutter/material.dart';
import 'package:newsapp/logic/models/article.dart';
import 'package:newsapp/logic/models/category.dart';
import 'package:newsapp/logic/services/dummyCategories.dart';
import 'package:newsapp/logic/services/news.dart';
import 'package:newsapp/ui/screens/article_screen.dart';
import 'package:newsapp/ui/widgets/app_bar.dart';
import 'package:newsapp/ui/widgets/category_tile.dart';
import 'package:newsapp/ui/widgets/news_tile.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = List<Category>();
  List<Article> articles = List<Article>();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
    _isLoading = true;
  }

  Future<void> getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: CategoryTile(
                              imgUrl: categories[i].imgUrl,
                              categoryName: categories[i].categoryName,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ArticleScreen(
                                      article: articles[i],
                                    ),
                                  ),
                                ),
                                child: NewsTile(
                                  imgUrl: articles[i].imgUrl ?? "",
                                  title: articles[i].title ?? "",
                                  description:
                                      articles[i].description ?? "",
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
