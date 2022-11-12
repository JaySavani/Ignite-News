import 'package:flutter/material.dart';
import 'package:news_app/views/category_news.dart';


// widget for first row categorytile
class CategoryTile extends StatelessWidget {
  final String imageUrl, categorieName;
  CategoryTile({required this.imageUrl, required this.categorieName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryNews(
                category: categorieName.toString().toLowerCase(),
              ),

            ));
      },
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 120,
                height: 80,
              ),
            ),
            Container(
              alignment: Alignment.center, // text(categoriename alignment)
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Text(
                categorieName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}