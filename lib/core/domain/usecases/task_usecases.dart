import 'package:flutter/material.dart';
import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/data/models/task_model.dart';
import 'package:up_todo/core/data/repositories/task_repository_impl.dart';

class TaskUsecases {
  void call(String title, String description, String date, String time,
      String flag, String category, Color color, String icon) {
    TaskModel task = TaskModel(
        title: title,
        description: description,
        flag: flag,
        category: category,
        date: date,
        time: time,
        color: color,
        icon: icon);
    locator<TaskRepositoryImpl>().addNewTask(task);
  }

  Stream callForTask() {
    return locator<TaskRepositoryImpl>().getTasks();
  }

  void callToUpdateTask(TaskModel task, String id) {
    locator<TaskRepositoryImpl>().updateTask(task, id);
  }

  void callToDelete(String id) {
    locator<TaskRepositoryImpl>().deleteTask(id);
  }
}
