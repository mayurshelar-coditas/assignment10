part of 'main_screen_bloc.dart';

sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}

final class ShowAddNewModalSheetState extends MainScreenState {}

final class ShowCalendarDialogState extends MainScreenState {}

final class ShowFlagDialogState extends MainScreenState {}

final class ShowChooseCategoryDialogState extends MainScreenState {}

final class SelectedFlagState extends MainScreenState {
  final int selectedFlag;

  SelectedFlagState({required this.selectedFlag});
}

final class SelectedCategoryState extends MainScreenState {
  final String selectedCategory, icon;
  final Color color;

  SelectedCategoryState(
      {required this.icon,
      required this.color,
      required this.selectedCategory});
}

final class SaveDayAndShowTimerDialogState extends MainScreenState {
  final String selectedDay;

  SaveDayAndShowTimerDialogState({required this.selectedDay});
}

final class SaveTimeState extends MainScreenState {
  final String time;

  SaveTimeState({required this.time});
}

final class ErrorSavingTaskState extends MainScreenState {}

final class SuccessSavingTaskState extends MainScreenState {}

final class SuccessSavingCategoryState extends MainScreenState {
  final String selectedCategory, selectedIcon;
  final Color selectedColor;

  SuccessSavingCategoryState(
      {required this.selectedColor,
      required this.selectedIcon,
      required this.selectedCategory});
}

final class ErrorSavingCategoryState extends MainScreenState {}

final class SuccessSavingFlagState extends MainScreenState {
  final int selectedFlag;

  SuccessSavingFlagState({required this.selectedFlag});
}

final class ErrorSavingFlagState extends MainScreenState {}

final class SaveTaskState extends MainScreenState {}
