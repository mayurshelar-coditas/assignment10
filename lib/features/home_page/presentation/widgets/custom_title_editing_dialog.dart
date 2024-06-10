import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home_page/presentation/bloc/home_bloc_bloc.dart';

class CustomTitleEditingDialog extends StatefulWidget {
  const CustomTitleEditingDialog(
      {super.key, required this.titleText, required this.descriptionText});

  final String titleText, descriptionText;

  @override
  State<CustomTitleEditingDialog> createState() =>
      _CustomTitleEditingDialogState();
}

class _CustomTitleEditingDialogState extends State<CustomTitleEditingDialog> {
  late TextEditingController titleTextEditController;

  late TextEditingController descriptionTextEditController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleTextEditController = TextEditingController(text: widget.titleText);
    descriptionTextEditController =
        TextEditingController(text: widget.descriptionText);
  }

  @override
  void dispose() {
    titleTextEditController.dispose();
    descriptionTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: AppPallete.bottomNavBarColor,
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Edit Task Title',
              style: Fonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppPallete.whiteColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: AppPallete.borderColor,
          ),
          const SizedBox(
            height: 16,
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: titleTextEditController,
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
                  height: 24,
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: Fonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppPallete.primaryColorForButton,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    FilledButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(
                              OnEditTitleButtonClickedEvent(
                                title: titleTextEditController.text.trim(),
                                description:
                                    descriptionTextEditController.text.trim(),
                              ),
                            );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppPallete.primaryColorForButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Edit',
                          style: Fonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppPallete.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
