import 'package:up_todo/core/data/models/category_model.dart';


abstract interface class CategoryRepository {
  Stream getCategories();

  Future<void> addCategory(CategoryModel category);
}
