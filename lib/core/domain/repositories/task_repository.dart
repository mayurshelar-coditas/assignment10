import 'package:up_todo/core/domain/entities/task_entity.dart';

abstract interface class TaskRepository {
  Future<void> addNewTask(TaskEntity task);

  Stream getTasks();

  Future<void> updateTask(TaskEntity task, String id);

  Future<void> deleteTask(String id);
}
