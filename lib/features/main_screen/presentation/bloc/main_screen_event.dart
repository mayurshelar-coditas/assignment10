part of 'main_screen_bloc.dart';

sealed class MainScreenEvent {}

final class OnAddNewTaskButtonClicked extends MainScreenEvent {}

final class OnAddDataSelectedEvent extends MainScreenEvent {}

final class OnCalendarButtonClickedEvent extends MainScreenEvent {}

final class OnDateChangedEvent extends MainScreenEvent {}

final class SavePartialDataSaveEvent extends MainScreenEvent {}

final class OnDetailsSaveButtonClickedEvent extends MainScreenEvent {}

final class OnFlagButtonClickedEvent extends MainScreenEvent {}

final class OnChooseCategoryButtonClickedEvent extends MainScreenEvent {}

final class OnFlagSelectedEvent extends MainScreenEvent {
  final int selectedFlag;

  OnFlagSelectedEvent({required this.selectedFlag});
}

final class OnCategorySelectedEvent extends MainScreenEvent {
  final String selectedCategory, icon;
  final Color color;

  OnCategorySelectedEvent(
      {required this.color,
      required this.icon,
      required this.selectedCategory});
}

final class OnDaySelectedEvent extends MainScreenEvent {
  final String selectedDay;

  OnDaySelectedEvent({required this.selectedDay});
}

final class OnTimeSelectedEvent extends MainScreenEvent {
  final String time;

  OnTimeSelectedEvent({required this.time});
}

final class OnAddNewTaskSaveButtonClicked extends MainScreenEvent {}

final class OnAddCategoryButtonClickedEvent extends MainScreenEvent {
  final String? selectedCategory, icon;
  final Color? color;

  OnAddCategoryButtonClickedEvent(
      {required this.color,
      required this.icon,
      required this.selectedCategory});
}

final class OnFlagSaveButtonClickedEvent extends MainScreenEvent {
  final int? selectedFlag;

  OnFlagSaveButtonClickedEvent({required this.selectedFlag});
}

final class OnSaveNewTask extends MainScreenEvent {
  final String? selectedFlag;
  final String? selectedCategory, selectedDay, time;

  OnSaveNewTask({
    required this.selectedFlag,
    required this.selectedCategory,
    required this.selectedDay,
    required this.time,
  });
}
