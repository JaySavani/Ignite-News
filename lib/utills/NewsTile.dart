import 'package:flutter/material.dart';
import 'package:news_app/views/article_view.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;
  final bool is_dark;

  const NewsTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
    required this.is_dark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(newsurl: url),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: is_dark ? Colors.white : Colors.black87,
                  ),
            ),
            SizedBox(height: 8),
            Text(
              desc,
              style: TextStyle(color: is_dark ? Colors.white70 : Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
