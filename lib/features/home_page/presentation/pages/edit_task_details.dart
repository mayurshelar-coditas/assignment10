import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/domain/usecases/task_usecases.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home_page/presentation/bloc/home_bloc_bloc.dart';
import 'package:up_todo/features/home_page/presentation/widgets/Edit_Category_Dialog.dart';
import 'package:up_todo/features/home_page/presentation/widgets/custom_category_container.dart';
import 'package:up_todo/features/home_page/presentation/widgets/custom_title_editing_dialog.dart';
import 'package:up_todo/features/home_page/presentation/widgets/date_time_container.dart';
import 'package:up_todo/features/home_page/presentation/widgets/edit_data_time_dialog.dart';
import 'package:up_todo/features/home_page/presentation/widgets/edit_flag_dialog.dart';
import 'package:up_todo/features/home_page/presentation/widgets/edit_time_dialog.dart';
import 'package:up_todo/features/home_page/presentation/widgets/flag_container.dart';
import 'package:up_todo/features/home_page/presentation/widgets/title_description_container.dart';

class EditTaskDetails extends StatelessWidget {
  const EditTaskDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? selectedDate,
        selectedTime,
        category,
        icon,
        title,
        description,
        id,
        flag;

    Color? color;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
        leadingWidth: 80,
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppPallete.searchBarColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
          icon: SvgPicture.asset("assets/icons/cross.svg"),
          onPressed: () => context.read<HomeBloc>().add(
                OnCrossButtonClickedEvent(),
              ),
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppPallete.searchBarColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            icon: SvgPicture.asset("assets/icons/repeat.svg"),
            onPressed: () {},
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionableState,
        listener: (context, state) {
          switch (state) {
            case DeleteTaskState():
              locator<TaskUsecases>().callToDelete(state.id);
              context.pop();
              break;
            case SuccessEditingTaskState():
              locator<TaskUsecases>().callToUpdateTask(state.model, id!);
              context.pop();
              break;

            case ErrorSavingDateState():
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please Select the date first!'),
                ),
              );
              break;
            case SuccessSavingDateState():
              selectedDate = state.selectedDate;
              print(state.selectedDate);
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => Dialog(
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: EditTimeDialog(),
                ),
              );
              break;

            case CancelEditingState():
              context.pop();
              break;
            case ShowTitleEditingDialogState():
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => Dialog(
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: CustomTitleEditingDialog(
                    titleText: state.title,
                    descriptionText: state.description,
                  ),
                ),
              );
              break;
            case ShowCategoryPickerDialogState():
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => Dialog(
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: EditCategoryDialog(),
                ),
              );
              break;
            case ShowFlagPickerDialogState():
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => const Dialog(
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: EditFlagDialog(),
                ),
              );
              break;
            case ShowTableCalendarState():
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => Dialog(
                  insetPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: MediaQuery.of(context).viewInsets.bottom),
                  child: const EditDataTimeDialog(),
                ),
              );
              break;
            case ErrorSavingCategoryState():
              print("Error saving category");
              break;
            default:
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    current is! HomeActionableState && current is TitleState,
                builder: (context, state) {
                  switch (state) {
                    case SuccessSavingTitleState():
                      title = state.title;
                      description = state.description;
                      print(title);
                      Navigator.pop(context);
                      return Stack(
                        children: [
                          TitleDescriptionContainer(
                              title: title!, description: description!),
                          Positioned(
                            top: 8,
                            right: 0,
                            child: IconButton(
                              onPressed: () => context.read<HomeBloc>().add(
                                    OnPencilButtonClickedEvent(
                                      title: state.title,
                                      description: state.description,
                                    ),
                                  ),
                              icon: SvgPicture.asset("assets/icons/pencil.svg"),
                            ),
                          ),
                        ],
                      );
                    case InitiateTaskEditWidgetState():
                      id = state.id;
                      return Stack(
                        children: [
                          TitleDescriptionContainer(
                              title: state.title,
                              description: state.description),
                          Positioned(
                            top: 8,
                            right: 0,
                            child: IconButton(
                              onPressed: () => context.read<HomeBloc>().add(
                                    OnPencilButtonClickedEvent(
                                      title: state.title,
                                      description: state.description,
                                    ),
                                  ),
                              icon: SvgPicture.asset("assets/icons/pencil.svg"),
                            ),
                          ),
                        ],
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/timer.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Task Time :',
                    style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.titleAndSubtitleColor),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  GestureDetector(
                    onTap: () => context
                        .read<HomeBloc>()
                        .add(OnDateTimeContainerClickedEvent()),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) =>
                          current is! HomeActionableState &&
                          current is DateTimeState,
                      builder: (context, state) {
                        switch (state) {
                          case SuccessSavingTimeState():
                            selectedTime = state.selectedTime;
                            print(selectedTime);
                            return DateTimeContainer(
                                date: selectedDate!, time: state.selectedTime!);
                          case InitiateTaskEditWidgetState():
                            return DateTimeContainer(
                                date: state.day, time: state.time);
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/tag.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Task Category :',
                    style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.titleAndSubtitleColor),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('category Button tapped');
                      context
                          .read<HomeBloc>()
                          .add(OnCategoryButtonClickedEvent());
                    },
                    child: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) =>
                          current is! HomeActionableState &&
                          current is CategoryState,
                      // && current is CategoryState,
                      builder: (context, state) {
                        switch (state) {
                          case SuccessSavingCategoryState():
                            color = state.color!;
                            icon = state.icon;
                            category = state.category;
                            print('$color $category $icon');
                            Navigator.pop(context);
                            return CustomCategoryContainer(
                                category: state.category!, icon: state.icon!);
                          case InitiateTaskEditWidgetState():
                            return CustomCategoryContainer(
                                category: state.category, icon: state.icon);
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/timer.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Task Priority :',
                    style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.titleAndSubtitleColor),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  GestureDetector(
                    onTap: () => context
                        .read<HomeBloc>()
                        .add(OnFlagButtonClickedEvent()),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) =>
                          current is! HomeActionableState &&
                          current is PriorityState,
                      builder: (context, state) {
                        switch (state) {
                          case SuccessSavingFlagState():
                            Navigator.pop(context);
                            flag = state.flag;
                            return FlagContainer(flag: state.flag!);
                          case InitiateTaskEditWidgetState():
                            return FlagContainer(flag: state.flag);
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(
                        OnDeleteTaskButtonEvent(id: id!),
                      );
                },
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/trash.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Delete Task',
                      style: Fonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppPallete.redColor),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 12,
                child: SizedBox(),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(
                          OnEditTaskButtonClickedEvent(
                              id: id,
                              title: title,
                              description: description,
                              color: color,
                              icon: icon,
                              category: category,
                              flag: flag,
                              date: selectedDate,
                              time: selectedTime),
                        );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPallete.primaryColorForButton,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                  child: Text(
                    'Edit Task',
                    style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.titleAndSubtitleColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
