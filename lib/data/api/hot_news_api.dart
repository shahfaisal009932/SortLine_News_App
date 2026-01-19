import 'dart:convert';

import 'package:epic_news/models/article_model.dart';
import 'package:http/http.dart' as http;

class HotNewsApi {
  List<ArticleModel> hotNews = [];

  Future<void> getHotNewsApi() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=3a6873ac84d840bd90375ab3db2eb9b1";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel artModel = ArticleModel(
            urlToImage: element["urlToImage"],
            title: element["title"],
            desc: element["description"],
            url: element["url"],
          );
          hotNews.add(artModel);
        }
      });
    }
  }
}
