import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/data/datasource/remote_data_source/task_datasource.dart';
import 'package:up_todo/core/data/models/task_model.dart';
import 'package:up_todo/core/domain/entities/task_entity.dart';
import 'package:up_todo/core/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  @override
  Future<void> addNewTask(TaskEntity task) async {
    await locator<TaskDatasource>().addNewTask(task as TaskModel);
  }

  @override
  Stream getTasks() {
    return locator<TaskDatasource>().getListofTask();
  }
  
  @override
  Future<void> updateTask(TaskEntity task, String id) async {
    await locator<TaskDatasource>().updateTask(task as TaskModel, id);
  }
  
  @override
  Future<void> deleteTask(String id) async {
    await locator<TaskDatasource>().delete(id);
  }
}
