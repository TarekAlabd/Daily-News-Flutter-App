import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/logic/models/article.dart';

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=us&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=483cfdf815b34dd48e59c99e7767167f';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          news.add(
            Article(
              title: element['title'],
              imgUrl: element['urlToImage'],
              author: element['author'],
              url: element['url'],
              description: element['description'],
              content: element['content'],
              publishedAt: DateTime.parse(element['publishedAt']),
            ),
          );
        }
      });
    }
  }
}

class CategoryNewsHelper {
  List<Article> news = [];

  Future<void> getCategoryNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?category=$category&country=us&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=483cfdf815b34dd48e59c99e7767167f';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          news.add(
            Article(
              title: element['title'],
              imgUrl: element['urlToImage'],
              author: element['author'],
              url: element['url'],
              description: element['description'],
              content: element['content'],
              publishedAt: DateTime.parse(element['publishedAt']),
            ),
          );
        }
      });
    }
  }
}
