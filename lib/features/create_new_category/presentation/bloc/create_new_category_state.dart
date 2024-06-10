part of 'create_new_category_bloc.dart';

sealed class CreateNewCategoryState {}

sealed class CreateNewCategoryActionState extends CreateNewCategoryState {}

sealed class ButtonStates extends CreateNewCategoryState {}

sealed class ColorStates extends CreateNewCategoryState {}

final class CreateNewCategoryInitial extends CreateNewCategoryState {}

final class CategoryColorSelectedState extends ColorStates {
  final int selectedColor;

  CategoryColorSelectedState({required this.selectedColor});
}

final class ShowIconDialogState extends CreateNewCategoryActionState {}

final class SelectedIconState extends ButtonStates {
  final String selectedIcon;

  SelectedIconState({required this.selectedIcon});
}

final class SuccessSavingSelectedIconState extends ButtonStates {
  final String selectedIcon;

  SuccessSavingSelectedIconState({required this.selectedIcon});
}

final class ErrorSavingIconState extends CreateNewCategoryActionState {}

final class ShowIconDialogWithSelectedIconState
    extends CreateNewCategoryActionState {
  final String selectedIcon;

  ShowIconDialogWithSelectedIconState({required this.selectedIcon});
}

final class SuccessSavingNewCategoryState extends CreateNewCategoryActionState {
  final String name, icon;
  final Color color;

  SuccessSavingNewCategoryState(
      {required this.name, required this.icon, required this.color});
}

final class ErrorSavingNewCategoryState extends CreateNewCategoryState {}
