import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/views/search_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({required this.newsurl});
  final String newsurl;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  bool is_dark = false;

  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  // @override
  // void initState() {
  //   super.initState();
  //   // Enable virtual display.
  //   if (Platform.isAndroid) WebView.platform = AndroidWebView();
  // }

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
    home:Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: is_dark ? Colors.white : Colors.black,
        ),
        backgroundColor: is_dark ? Colors.black12 : Colors.white,
        title: Text(
          "Ignite News",
          style: TextStyle(
            color:
            is_dark ? Colors.white : Color.fromARGB(255, 102, 109, 255),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ));
            },
            icon: Icon(Icons.search,
                color: is_dark ? Colors.white : Colors.black),
          ),
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
        // centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.newsurl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    ),
    );
  }
}
