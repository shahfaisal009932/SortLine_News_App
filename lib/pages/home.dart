import 'package:epic_news/models/article_model.dart';
import 'package:epic_news/models/category_model.dart';
import 'package:epic_news/pages/category_news_page.dart';
import 'package:epic_news/pages/web_view_page.dart';
import 'package:epic_news/data/local_data/category_name_data.dart';
import 'package:epic_news/data/api/hot_news_api.dart';
import 'package:epic_news/data/api/trending_news_api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> trending = [];
  List<ArticleModel> hottest = [];
  bool loading = true;
  @override
  void initState() {
    categories = getCategory();
    getTrendingNews();
    getHottestNews();
    super.initState();
  }

  getTrendingNews() async {
    TrendingNewsApi newsClass = TrendingNewsApi();
    await newsClass.getTrendingNewsApi();
    trending = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  getHottestNews() async {
    HotNewsApi Tclass = HotNewsApi();
    await Tclass.getHotNewsApi();
    hottest = Tclass.hotNews;
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sort",
                    style: TextStyle(
                      color: Color(0xff3280ef),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Line",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                "Hottest News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: MediaQuery.of(context).size.height / 2.72,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: hottest.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebViewPage(blogUrl: hottest[index].url!),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 3.0,
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                    child: Image.network(
                                      hottest[index].urlToImage ??
                                          "https://via.placeholder.com/150",
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.1,
                                      fit: BoxFit.cover,
                                      height: 120,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  child: Text(
                                    maxLines: 2,
                                    hottest[index].title ??
                                        "No title available",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(188, 0, 0, 0),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  child: Text(
                                    maxLines: 2,
                                    hottest[index].desc ??
                                        "No description available",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(151, 0, 0, 0),
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 80.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xff3280ef),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 3.2,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Explore",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 135.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      categoryname: categories[index].categoryName,
                      image: categories[index].image,
                    );
                  },
                ),
              ),
              Text(
                "Trending News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: trending.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebViewPage(blogUrl: trending[index].url!),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: Image.network(
                                trending[index].urlToImage!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: Text(
                                    trending[index].title!,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(188, 0, 0, 0),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: Text(
                                    maxLines: 2,
                                    trending[index].desc!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(151, 0, 0, 0),
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final image, categoryname;
  CategoryTile({this.image, this.categoryname});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNewsPage(name: categoryname),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
              ),
              child: Center(
                child: Text(
                  categoryname,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
