import 'package:up_todo/core/data/models/category_model.dart';
import 'package:up_todo/core/data/repositories/category_repositories_impl.dart';
import 'package:up_todo/core/di/di_container.dart';

class CategoryUsecases {
  Stream getCategorie() {
    return locator<CategoryRepositoriesImpl>().getCategories();
  }

  void addNewCategory(CategoryModel category) {
    locator<CategoryRepositoriesImpl>().addCategory(category);
  }
}
