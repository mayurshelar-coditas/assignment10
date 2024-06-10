import 'package:flutter/material.dart';

class TaskEntity {
  final String title, description, flag, category, date, time, icon;
  final Color color;

  TaskEntity({
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.flag,
    required this.category,
    required this.date,
    required this.time,
  });
}
