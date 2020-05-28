import 'package:flutter/material.dart';
import 'package:newsapp/logic/models/article.dart';
import 'package:newsapp/ui/screens/original_article_screen.dart';
import 'package:newsapp/ui/widgets/app_bar.dart';


class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: specificAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Image.network(
                      article.imgUrl,
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${article.publishedAt}',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${article.title}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${article.author}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${article.description}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 32),
                        Text(
                          'To read the whole article,',
                          style: TextStyle(
//                                  color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => OriginalArticleScreen(
                                      articleUrl: article.url,
                                    )),
                          ),
                          child: Text(
                            'Go to the original page.',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
