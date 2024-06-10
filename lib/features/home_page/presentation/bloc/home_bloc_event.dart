part of 'home_bloc_bloc.dart';

sealed class HomeEvent {}

final class OnTaskClickedForEditingEvent extends HomeEvent {
  final String title, description, day, time, flag, category, icon, id;

  OnTaskClickedForEditingEvent(
      {required this.id,
      required this.title,
      required this.description,
      required this.day,
      required this.time,
      required this.flag,
      required this.category,
      required this.icon});
}

final class ListIsEmptyEvent extends HomeEvent {}

final class OnCrossButtonClickedEvent extends HomeEvent {}

final class OnPencilButtonClickedEvent extends HomeEvent {
  final String title, description;

  OnPencilButtonClickedEvent({required this.title, required this.description});
}

final class OnCategoryButtonClickedEvent extends HomeEvent {}

final class OnFlagButtonClickedEvent extends HomeEvent {}

final class OnDateTimeContainerClickedEvent extends HomeEvent {}

final class OnEditDateButtonClickedEvent extends HomeEvent {
  final String? selectedDate;

  OnEditDateButtonClickedEvent({required this.selectedDate});
}

final class OnEditTimeButtonClickedEvent extends HomeEvent {
  final String? time;

  OnEditTimeButtonClickedEvent({required this.time});
}

final class OnEditCategoryButtonClickedEvent extends HomeEvent {
  final String? icon, category;
  final Color? color;

  OnEditCategoryButtonClickedEvent(
      {required this.color, required this.icon, required this.category});
}

final class OnEditFlagButtonClickedEvent extends HomeEvent {
  final String? flag;

  OnEditFlagButtonClickedEvent({required this.flag});
}

final class OnEditTitleButtonClickedEvent extends HomeEvent {
  final String? title, description;

  OnEditTitleButtonClickedEvent(
      {required this.title, required this.description});
}

final class OnEditTaskButtonClickedEvent extends HomeEvent {
  final String? id, title, description, icon, category, flag, date, time;
  final Color? color;

  OnEditTaskButtonClickedEvent(
      {required this.id,
      required this.title,
      required this.description,
      required this.color,
      required this.icon,
      required this.category,
      required this.flag,
      required this.date,
      required this.time});
}

final class OnDeleteTaskButtonEvent extends HomeEvent {
  final String id;

  OnDeleteTaskButtonEvent({required this.id});
}
