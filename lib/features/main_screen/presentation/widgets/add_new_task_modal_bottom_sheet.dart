import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/main_screen/presentation/bloc/main_screen_bloc.dart';

final class AddNewTaskModalBottomSheet {
  void addNewTask(
      BuildContext context,
      TextEditingController titleTextEditController,
      TextEditingController descriptionTextEditController,
      GlobalKey<FormState> formKey) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppPallete.bottomNavBarColor,
      builder: (BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            color: AppPallete.bottomNavBarColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: Fonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.whiteColor.withOpacity(0.87),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: titleTextEditController,
                  autofocus: true,
                  style: Fonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppPallete.whiteColor.withOpacity(0.87),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: Fonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppPallete.whiteColor.withOpacity(0.87),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppPallete.borderColor, width: 1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionTextEditController,
                  style: Fonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppPallete.whiteColor.withOpacity(0.87),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                    hintStyle: Fonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppPallete.whiteColor.withOpacity(0.87),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppPallete.borderColor, width: 1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/timer.svg'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<MainScreenBloc>().add(
                              OnCalendarButtonClickedEvent(),
                            );
                      },
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    IconButton(
                      // padding: const EdgeInsets.only(left: -8),
                      icon: SvgPicture.asset('assets/icons/tag.svg'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<MainScreenBloc>().add(
                              OnChooseCategoryButtonClickedEvent(),
                            );
                      },
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset('assets/icons/flag.svg'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<MainScreenBloc>().add(
                              OnFlagButtonClickedEvent(),
                            );
                      },
                    ),
                    const Expanded(
                      flex: 10,
                      child: SizedBox(),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(-8),
                      icon: SvgPicture.asset('assets/icons/send.svg'),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<MainScreenBloc>()
                              .add(OnAddNewTaskSaveButtonClicked());
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
