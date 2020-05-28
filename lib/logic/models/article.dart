import 'package:flutter/material.dart';

class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String imgUrl;
  final String content;
  final DateTime publishedAt;

  Article({
    @required this.publishedAt,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.imgUrl,
    @required this.content,
  });
}
