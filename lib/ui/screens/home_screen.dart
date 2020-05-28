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
  List<Article> filteredArticles = List<Article>();
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
      filteredArticles = articles;
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      child: TextField(
                        onChanged: (article) {
                          setState(() {
                            filteredArticles = articles
                                .where(
                                  (element) =>
                                      element.title.toLowerCase().contains(
                                            article.toLowerCase(),
                                          ),
                                )
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
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
                          itemCount: filteredArticles.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ArticleScreen(
                                      article: filteredArticles[i],
                                    ),
                                  ),
                                ),
                                child: NewsTile(
                                  imgUrl: filteredArticles[i].imgUrl ?? "",
                                  title: filteredArticles[i].title ?? "",
                                  description:
                                      filteredArticles[i].description ?? "",
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
