import 'package:get_it/get_it.dart';
import 'package:up_todo/core/data/datasource/remote_data_source/category_datasource.dart';
import 'package:up_todo/core/data/datasource/remote_data_source/task_datasource.dart';
import 'package:up_todo/core/data/repositories/category_repositories_impl.dart';
import 'package:up_todo/core/data/repositories/task_repository_impl.dart';
import 'package:up_todo/core/domain/usecases/category_usecases.dart';
import 'package:up_todo/core/domain/usecases/task_usecases.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/add_new_task_modal_bottom_sheet.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerSingleton(TaskDatasource());
  locator.registerSingleton(TaskRepositoryImpl());
  locator.registerSingleton(AddNewTaskModalBottomSheet());
  locator.registerSingleton(TaskUsecases());

  locator.registerSingleton(CategoryDatasource());
  locator.registerSingleton(CategoryRepositoriesImpl());
  locator.registerSingleton(CategoryUsecases());
}
