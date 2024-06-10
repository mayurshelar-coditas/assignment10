part of 'home_bloc_bloc.dart';

sealed class HomeState {}

final class HomeBlocInitial extends HomeState {}

final class TitleState extends HomeState {}

final class DateTimeState extends HomeState {}

final class CategoryState extends HomeState {}

final class PriorityState extends HomeState {}

sealed class HomeActionableState extends HomeState {}

final class NavigateToEditTaskScreen extends HomeActionableState {}

final class InitiateTaskEditWidgetState extends HomeState {
  final String title, description, day, time, flag, category, icon, id;

  InitiateTaskEditWidgetState(
      {required this.id,
      required this.title,
      required this.description,
      required this.day,
      required this.time,
      required this.flag,
      required this.category,
      required this.icon});
}

final class ListIsEmptyState extends HomeActionableState {}

final class CancelEditingState extends HomeActionableState {}

final class ShowTitleEditingDialogState extends HomeActionableState {
  final String title, description;

  ShowTitleEditingDialogState({required this.title, required this.description});
}

final class ShowCategoryPickerDialogState extends HomeActionableState {}

final class ShowFlagPickerDialogState extends HomeActionableState {}

final class ShowTableCalendarState extends HomeActionableState {}

final class ErrorSavingDateState extends HomeActionableState {}

final class SuccessSavingDateState extends HomeActionableState {
  final String? selectedDate;

  SuccessSavingDateState({required this.selectedDate});
}

final class ErrorSavingTimeState extends HomeActionableState {}

final class SuccessSavingTimeState extends DateTimeState {
  final String? selectedTime;

  SuccessSavingTimeState({required this.selectedTime});
}

final class ErrorSavingCategoryState extends HomeActionableState {}

final class SuccessSavingCategoryState extends CategoryState {
  final String? icon, category;
  final Color? color;

  SuccessSavingCategoryState(
      {required this.color, required this.icon, required this.category});
}

final class ErrorSavingFlagState extends HomeActionableState {}

final class SuccessSavingFlagState extends PriorityState {
  final String? flag;
  SuccessSavingFlagState({required this.flag});
}

final class ErrorSavingTitleState extends HomeActionableState {}

final class SuccessSavingTitleState extends TitleState {
  final String title, description;

  SuccessSavingTitleState({required this.title, required this.description});
}

final class ErrorEditingTaskState extends HomeActionableState {}

final class SuccessEditingTaskState extends HomeActionableState {
  final TaskModel model;

  SuccessEditingTaskState({required this.model});
}

final class DeleteTaskState extends HomeActionableState {
  final String id;

  DeleteTaskState({required this.id});
}
