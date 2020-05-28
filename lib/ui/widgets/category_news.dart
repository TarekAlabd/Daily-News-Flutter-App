import 'package:flutter/material.dart';
import 'package:newsapp/logic/models/article.dart';
import 'package:newsapp/logic/services/news.dart';
import 'package:newsapp/ui/screens/article_screen.dart';
import 'package:newsapp/ui/widgets/app_bar.dart';
import 'package:newsapp/ui/widgets/news_tile.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({Key key, this.category}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<Article> articles = List<Article>();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getCategoryNews();
  }

  Future<void> getCategoryNews() async {
    CategoryNewsHelper news = CategoryNewsHelper();
    await news.getCategoryNews(widget.category);
    articles = news.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: specificAppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
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
                                  description: articles[i].description ?? "",
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
