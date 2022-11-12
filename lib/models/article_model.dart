class ArticleModel {
  late var author;
  late var title;
  late var description;
  late var url;
  late var urlToImage;
  late var content;
  late var publishedAt;

  ArticleModel({
    required this.author,
    required this.title,
    required this.url,
    required this.description,
    required this.urlToImage,
    required this.content,
    required this.publishedAt,
  });
}
