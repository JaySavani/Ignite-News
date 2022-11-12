import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/utills/NewsTile.dart';
import 'package:news_app/views/pagenotfound.dart';
import 'package:news_app/utills/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ArticleModel> articles = <ArticleModel>[];
  String text="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchNews();
  }

  getSearchNews() async {
    print(text);
    SearchNewsClass newsclass = SearchNewsClass();
    await newsclass.getNews(text);
    articles = newsclass.news;
    print(articles.length);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: is_dark
          ? ThemeData(
              brightness: Brightness.dark,
            )
          : ThemeData(
              brightness: Brightness.light,
            ),

      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            color: is_dark ? Colors.white : Colors.black,
          ),
          backgroundColor: is_dark ? Colors.black12 : Colors.white,
          title: Text(
            "Search News",
            style: TextStyle(
              color: is_dark ? Colors.white : Color.fromARGB(255, 102, 109, 255),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (is_dark == false)
                    is_dark = true;
                  else
                    is_dark = false;
                });
              },
              icon: Icon(
                is_dark ? Icons.dark_mode : Icons.light_mode,
                color: is_dark ? Colors.white : Colors.black,
              ),
            ),
          ],
          elevation: 0.0,

        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                // controller: searchController,
                onChanged: (text) {
                  setState(() {
                    this.text=text;
                  });
                  getSearchNews();
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: text==""?  Text(
                  "Please, Enter Some Text",
                  style: TextStyle(
                    color: is_dark ? Colors.white : Color.fromARGB(255, 102, 109, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ):
                articles.isEmpty
                    ? PageNotFound()
                    : ListView.builder(
                        itemCount: articles.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NewsTile(
                            imageUrl: articles[index]
                                .urlToImage, // after .attribute of api
                            title: articles[index].title,
                            desc: articles[index].description,
                            url: articles[index].url,
                            is_dark: is_dark,
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
