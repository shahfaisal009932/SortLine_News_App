import 'dart:convert';

import 'package:epic_news/models/category_news_model.dart';
import 'package:http/http.dart' as http;

class CategoryNewsApi {
  List<CategoryNewsModel> categories = [];

  Future<void> getCategoryNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=3a6873ac84d840bd90375ab3db2eb9b1";
    // "https://newsapi.org/v2/top-headlines?country=us&category=$category";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((e) {
        if (e["urlToImage"] != null && e["description"] != null) {
          CategoryNewsModel categoryNewsModel = CategoryNewsModel(
            urlToImage: e["urlToImage"],
            title: e["title"],
            desc: e["description"],
            url: e["url"],
          );
          categories.add(categoryNewsModel);
        }
      });
    }
  }
}
