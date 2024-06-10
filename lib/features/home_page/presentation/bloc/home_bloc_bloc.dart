import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:up_todo/core/data/models/task_model.dart';
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeBlocInitial()) {
    on<HomeEvent>((event, emit) {});

    on<OnTaskClickedForEditingEvent>(onTaskClickedForEditingEvent);
    on<OnCrossButtonClickedEvent>(onCrossButtonClickedEvent);
    on<OnPencilButtonClickedEvent>(onPencilButtonClickedEvent);
    on<OnCategoryButtonClickedEvent>(onCategoryButtonClickedEvent);
    on<OnFlagButtonClickedEvent>(onFlagButtonClickedEvent);
    on<OnDateTimeContainerClickedEvent>(onDateTimeContainerClickedEvent);
    on<OnEditDateButtonClickedEvent>(onEditDateButtonClickedEvent);
    on<OnEditTimeButtonClickedEvent>(onEditTimeButtonClickedEvent);
    on<OnEditCategoryButtonClickedEvent>(onEditCategoryButtonClickedEvent);
    on<OnEditFlagButtonClickedEvent>(onEditFlagButtonClickedEvent);
    on<OnEditTitleButtonClickedEvent>(onEditTitleButtonClickedEvent);
    on<OnEditTaskButtonClickedEvent>(onEditTaskButtonClickedEvent);
    on<OnDeleteTaskButtonEvent>(onDeleteTaskButtonEvent);
  }

  FutureOr<void> onTaskClickedForEditingEvent(
      OnTaskClickedForEditingEvent event, Emitter<HomeState> emit) {
    emit(NavigateToEditTaskScreen());

    emit(InitiateTaskEditWidgetState(
      id: event.id,
      title: event.title,
      icon: event.icon,
      category: event.category,
      flag: event.flag,
      description: event.description,
      day: event.day,
      time: event.time,
    ));
  }

  FutureOr<void> onCrossButtonClickedEvent(
      OnCrossButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(CancelEditingState());
  }

  FutureOr<void> onPencilButtonClickedEvent(
      OnPencilButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(ShowTitleEditingDialogState(
        title: event.title, description: event.description));
  }

  FutureOr<void> onCategoryButtonClickedEvent(
      OnCategoryButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(ShowCategoryPickerDialogState());
  }

  FutureOr<void> onFlagButtonClickedEvent(
      OnFlagButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(ShowFlagPickerDialogState());
  }

  FutureOr<void> onDateTimeContainerClickedEvent(
      OnDateTimeContainerClickedEvent event, Emitter<HomeState> emit) {
    emit(ShowTableCalendarState());
  }

  FutureOr<void> onEditDateButtonClickedEvent(
      OnEditDateButtonClickedEvent event, Emitter<HomeState> emit) {
    if (event.selectedDate != null) {
      emit(SuccessSavingDateState(selectedDate: event.selectedDate));
    }
  }

  FutureOr<void> onEditTimeButtonClickedEvent(
      OnEditTimeButtonClickedEvent event, Emitter<HomeState> emit) {
    if (event.time != null) {
      emit(SuccessSavingTimeState(selectedTime: event.time));
    } else {
      emit(ErrorSavingDateState());
    }
  }

  FutureOr<void> onEditCategoryButtonClickedEvent(
      OnEditCategoryButtonClickedEvent event, Emitter<HomeState> emit) {
    if (event.color != null && event.category != null && event.icon != null) {
      print("Emitting success State");
      emit(SuccessSavingCategoryState(
          color: event.color!, icon: event.icon!, category: event.category!));
    } else {
      emit(ErrorSavingCategoryState());
    }
  }

  FutureOr<void> onEditFlagButtonClickedEvent(
      OnEditFlagButtonClickedEvent event, Emitter<HomeState> emit) {
    if (event.flag != null) {
      print("Success editing the flag ${event.flag}");
      emit(SuccessSavingFlagState(flag: event.flag));
    } else {
      emit(ErrorSavingFlagState());
    }
  }

  FutureOr<void> onEditTitleButtonClickedEvent(
      OnEditTitleButtonClickedEvent event, Emitter<HomeState> emit) {
    if (event.title != null &&
        event.title != "" &&
        event.description != null &&
        event.description != "") {
      emit(SuccessSavingTitleState(
          title: event.title!.trim(), description: event.description!.trim()));
    } else {
      emit(ErrorSavingTitleState());
    }
  }

  FutureOr<void> onEditTaskButtonClickedEvent(
      OnEditTaskButtonClickedEvent event, Emitter<HomeState> emit) {
    if (event.title != null &&
        event.description != null &&
        event.color != null &&
        event.category != null &&
        event.date != null &&
        event.time != null &&
        event.flag != null &&
        event.icon != null) {
      TaskModel task = TaskModel(
          title: event.title!,
          description: event.description!,
          flag: event.flag!,
          category: event.category!,
          date: event.date!,
          time: event.time!,
          color: event.color!,
          icon: event.icon!);
      emit(SuccessEditingTaskState(model: task));
    } else {
      emit(ErrorEditingTaskState());
    }
  }

  FutureOr<void> onDeleteTaskButtonEvent(
      OnDeleteTaskButtonEvent event, Emitter<HomeState> emit) {
    emit(DeleteTaskState(id: event.id));
  }
}
