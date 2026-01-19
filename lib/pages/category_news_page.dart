// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:epic_news/models/category_news_model.dart';
import 'package:epic_news/pages/web_view_page.dart';
import 'package:epic_news/data/api/category_news_api.dart';
import 'package:flutter/material.dart';

class CategoryNewsPage extends StatefulWidget {
  String name;
  CategoryNewsPage({required this.name});
  @override
  State<CategoryNewsPage> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNewsPage> {
  List<CategoryNewsModel> categories = [];
  bool loading = true;
  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    CategoryNewsApi showCategoryNews = CategoryNewsApi();
    await showCategoryNews.getCategoryNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3280ef),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Color(0xFF3280ef),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 6.5),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      image: categories[index].urlToImage,
                      title: categories[index].title,
                      desc: categories[index].desc,
                      url: categories[index].url,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final image, title, desc, url;
  CategoryTile({this.image, this.title, this.desc, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WebViewPage(blogUrl: url)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                image,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                title!,
                maxLines: 2,
                style: TextStyle(
                  color: Color.fromARGB(188, 0, 0, 0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                desc,
                maxLines: 2,
                style: TextStyle(
                  color: Color.fromARGB(151, 0, 0, 0),
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
