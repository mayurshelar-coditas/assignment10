import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home/presentation/widgets/custom_category_picker.dart';
import 'package:up_todo/features/home/presentation/widgets/custom_table_calendar.dart';

class CustomWidgets {
  static void addNewTask(
      BuildContext context,
      TextEditingController titleTextEditController,
      TextEditingController descriptionTextEditController,
      GlobalKey<FormState> formKey) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
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
                  // autofocus: true,
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
                      return 'Title cannot be empty';
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
                      onPressed: () => showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => const Dialog(
                          child: CustomTableCalendar(),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(-8),
                      icon: SvgPicture.asset('assets/icons/tag.svg'),
                      onPressed: () => showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => Dialog(
                          child: CustomCategoryPicker(),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(-8),
                      icon: SvgPicture.asset('assets/icons/flag.svg'),
                      onPressed: () {},
                    ),
                    const Expanded(
                      flex: 10,
                      child: SizedBox(),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(-8),
                      icon: SvgPicture.asset('assets/icons/send.svg'),
                      onPressed: () {},
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
