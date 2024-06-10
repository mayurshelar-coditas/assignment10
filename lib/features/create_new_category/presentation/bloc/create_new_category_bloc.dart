import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'create_new_category_event.dart';
part 'create_new_category_state.dart';

class CreateNewCategoryBloc
    extends Bloc<CreateNewCategoryEvent, CreateNewCategoryState> {
  CreateNewCategoryBloc() : super(CreateNewCategoryInitial()) {
    on<CreateNewCategoryEvent>((event, emit) {});
    on<OnColorSelectedEvent>(onColorSelectedEvent);
    on<OnChooseIconButtonClickedEvent>(onChooseIconButtonClickedEvent);
    on<OnIconSelectedEvent>(onIconSelectedEvent);
    on<OnIconSaveButtonClickedEvent>(onIconSaveButtonClickedEvent);
    on<OnChoosenIconClickedEvent>(onChoosenIconClickedEvent);
    on<OnSaveNewCategoryEvent>(onSaveNewCategoryEvent);
  }

  FutureOr<void> onColorSelectedEvent(
      OnColorSelectedEvent event, Emitter<CreateNewCategoryState> emit) {
    emit(CategoryColorSelectedState(selectedColor: event.selectedIndex));
  }

  FutureOr<void> onChooseIconButtonClickedEvent(
      OnChooseIconButtonClickedEvent event,
      Emitter<CreateNewCategoryState> emit) {
    emit(ShowIconDialogState());
  }

  FutureOr<void> onIconSelectedEvent(
      OnIconSelectedEvent event, Emitter<CreateNewCategoryState> emit) {
    emit(SelectedIconState(selectedIcon: event.selectedIcon));
  }

  FutureOr<void> onIconSaveButtonClickedEvent(
      OnIconSaveButtonClickedEvent event,
      Emitter<CreateNewCategoryState> emit) {
    if (event.selectedIcon != null) {
      emit(SuccessSavingSelectedIconState(selectedIcon: event.selectedIcon!));
    } else {
      emit(ErrorSavingIconState());
    }
  }

  FutureOr<void> onChoosenIconClickedEvent(
      OnChoosenIconClickedEvent event, Emitter<CreateNewCategoryState> emit) {
    emit(ShowIconDialogWithSelectedIconState(selectedIcon: event.selectedIcon));
  }

  FutureOr<void> onSaveNewCategoryEvent(
      OnSaveNewCategoryEvent event, Emitter<CreateNewCategoryState> emit) {
    if (event.name != null && event.icon != null && event.color != null) {
      print("savign successfullt");
      emit(SuccessSavingNewCategoryState(
          name: event.name!, icon: event.icon!, color: event.color!));
    } else {
      print("Error saving the new category");
      emit(ErrorSavingNewCategoryState());
    }
  }
}
