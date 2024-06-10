part of 'create_new_category_bloc.dart';

sealed class CreateNewCategoryEvent {}

final class OnColorSelectedEvent extends CreateNewCategoryEvent {
  final int selectedIndex;

  OnColorSelectedEvent({required this.selectedIndex});
}

final class OnChooseIconButtonClickedEvent extends CreateNewCategoryEvent {}

final class OnIconSelectedEvent extends CreateNewCategoryEvent {
  final String selectedIcon;

  OnIconSelectedEvent({required this.selectedIcon});
}

final class OnIconSaveButtonClickedEvent extends CreateNewCategoryEvent {
  final String? selectedIcon;

  OnIconSaveButtonClickedEvent({required this.selectedIcon});
}

final class OnChoosenIconClickedEvent extends CreateNewCategoryEvent {
  final String selectedIcon;

  OnChoosenIconClickedEvent({required this.selectedIcon});
}

final class OnSaveNewCategoryEvent extends CreateNewCategoryEvent {
  final String? name, icon;
  final Color? color;

  OnSaveNewCategoryEvent({required this.name, required this.icon, required this.color});
}
