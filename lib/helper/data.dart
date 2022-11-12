import 'package:flutter/foundation.dart';
import 'package:news_app/models/categori_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = <CategoryModel>[]; // list literal
  CategoryModel categoryModel;

  // 1
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Business";
  categoryModel.imageUrl = "assets/images/bussines.jpg";
  category.add(categoryModel);

  // 2
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = "assets/images/technology.jpg";
  category.add(categoryModel);

  // 3
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageUrl = "assets/images/entertainment.jpg";
  category.add(categoryModel);

  // 4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl = "assets/images/sports.jpg";
  category.add(categoryModel);

  // 4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.imageUrl = "assets/images/health.jpg";
  category.add(categoryModel);
  return category;
}
