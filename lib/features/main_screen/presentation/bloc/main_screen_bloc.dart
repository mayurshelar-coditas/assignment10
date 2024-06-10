import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenInitial()) {
    on<MainScreenEvent>((event, emit) {});
    on<OnAddNewTaskButtonClicked>(onAddNewTaskButtonClicked);
    on<OnCalendarButtonClickedEvent>(onCalendarButtonClickedEvent);
    on<OnFlagButtonClickedEvent>(onFlagButtonClickedEvent);
    on<OnChooseCategoryButtonClickedEvent>(onChooseCategoryButtonClickedEvent);
    on<OnFlagSelectedEvent>(onFlagSelectedEvent);
    on<OnCategorySelectedEvent>(onCategorySelectedEvent);
    on<OnDaySelectedEvent>(onDaySelectedEvent);
    on<OnTimeSelectedEvent>(onTimeSelectedEvent);
    on<OnAddNewTaskSaveButtonClicked>(onAddNewTaskSaveButtonClicked);
    on<OnAddCategoryButtonClickedEvent>(onAddCategoryButtonClickedEvent);
    on<OnFlagSaveButtonClickedEvent>(onFlagSaveButtonClickedEvent);
    on<OnSaveNewTask>(onSaveTask);
  }

  FutureOr<void> onAddNewTaskButtonClicked(
      OnAddNewTaskButtonClicked event, Emitter<MainScreenState> emit) {
    emit(ShowAddNewModalSheetState());
  }

  FutureOr<void> onCalendarButtonClickedEvent(
      OnCalendarButtonClickedEvent event, Emitter<MainScreenState> emit) {
    emit(ShowCalendarDialogState());
  }

  FutureOr<void> onFlagButtonClickedEvent(
      OnFlagButtonClickedEvent event, Emitter<MainScreenState> emit) {
    emit(ShowFlagDialogState());
  }

  FutureOr<void> onChooseCategoryButtonClickedEvent(
      OnChooseCategoryButtonClickedEvent event, Emitter<MainScreenState> emit) {
    emit(ShowChooseCategoryDialogState());
  }

  FutureOr<void> onFlagSelectedEvent(
      OnFlagSelectedEvent event, Emitter<MainScreenState> emit) {
    emit(SelectedFlagState(selectedFlag: event.selectedFlag));
  }

  FutureOr<void> onCategorySelectedEvent(
      OnCategorySelectedEvent event, Emitter<MainScreenState> emit) {
    emit(SelectedCategoryState(
      selectedCategory: event.selectedCategory,
      color: event.color,
      icon: event.icon,
    ));
  }

  FutureOr<void> onDaySelectedEvent(
      OnDaySelectedEvent event, Emitter<MainScreenState> emit) {
    emit(SaveDayAndShowTimerDialogState(selectedDay: event.selectedDay));
  }

  FutureOr<void> onTimeSelectedEvent(
      OnTimeSelectedEvent event, Emitter<MainScreenState> emit) {
    emit(SaveTimeState(time: event.time));
  }

  FutureOr<void> onAddNewTaskSaveButtonClicked(
      OnAddNewTaskSaveButtonClicked event, Emitter<MainScreenState> emit) {
    emit(SaveTaskState());
  }

  FutureOr<void> onAddCategoryButtonClickedEvent(
      OnAddCategoryButtonClickedEvent event, Emitter<MainScreenState> emit) {
    if (event.selectedCategory != null &&
        event.color != null &&
        event.icon != null) {
      emit(SuccessSavingCategoryState(
          selectedCategory: event.selectedCategory!,
          selectedColor: event.color!,
          selectedIcon: event.icon!));
    } else {
      emit(ErrorSavingCategoryState());
    }
  }

  FutureOr<void> onFlagSaveButtonClickedEvent(
      OnFlagSaveButtonClickedEvent event, Emitter<MainScreenState> emit) {
    if (event.selectedFlag == null) {
      emit(ErrorSavingFlagState());
    } else {
      emit(SuccessSavingFlagState(selectedFlag: event.selectedFlag!));
    }
  }

  FutureOr<void> onSaveTask(
      OnSaveNewTask event, Emitter<MainScreenState> emit) {
    if (event.selectedCategory == null ||
        event.selectedDay == null ||
        event.selectedFlag == null ||
        event.time == null) {
      emit(ErrorSavingTaskState());
    } else {
      emit(SuccessSavingTaskState());
    }
  }
}
