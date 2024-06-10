import 'package:up_todo/core/data/datasource/remote_data_source/category_datasource.dart';
import 'package:up_todo/core/data/models/category_model.dart';
import 'package:up_todo/core/di/di_container.dart';

import 'package:up_todo/core/domain/repositories/category_repository.dart';

class CategoryRepositoriesImpl implements CategoryRepository {
  @override
  Future<void> addCategory(CategoryModel category) async {
    await locator<CategoryDatasource>().addNewTask(category);
  }

  @override
  Stream getCategories() {
    return locator<CategoryDatasource>().getListofCategories();
  }
}
