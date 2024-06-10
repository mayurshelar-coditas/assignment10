import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/core/data/models/category_model.dart';
import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/domain/usecases/category_usecases.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/create_new_category/presentation/bloc/create_new_category_bloc.dart';
import 'package:up_todo/features/create_new_category/presentation/widgets/color_container_widget.dart';
import 'package:up_todo/features/create_new_category/presentation/widgets/custom_icon_dialog.dart';

class CreateNewCategoryPage extends StatefulWidget {
  const CreateNewCategoryPage({super.key});

  @override
  State<CreateNewCategoryPage> createState() => _CreateNewCategoryPageState();
}

class _CreateNewCategoryPageState extends State<CreateNewCategoryPage> {
  TextEditingController categoryTitleController = TextEditingController();
  GlobalKey<FormState> categoryForm = GlobalKey<FormState>();

  final List<Color> listOfColors = [
    AppPallete.colorCategoryOne,
    AppPallete.colorCategoryTwo,
    AppPallete.colorCategoryThree,
    AppPallete.colorCategoryFour,
    AppPallete.colorCategoryFive,
    AppPallete.colorCategorySix,
    AppPallete.colorCategorySeven,
    AppPallete.colorCategoryEight,
  ];

  @override
  void dispose() {
    categoryTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? icon;
    Color? color;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
      ),
      backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
      body: BlocListener<CreateNewCategoryBloc, CreateNewCategoryState>(
        listenWhen: (previous, current) =>
            current is CreateNewCategoryActionState,
        listener: (context, state) {
          switch (state) {
            case ShowIconDialogState():
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => const Dialog(
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: CustomIconDialog(),
                ),
              );
              break;
            case SuccessSavingNewCategoryState():
              //Add the new color to the sharedPreferecences and also notify the mainscreenBloc to do necessary operations
              String color = state.color.value.toString();
              CategoryModel category = CategoryModel(
                  name: state.name, color: color, icon: state.icon);
              locator<CategoryUsecases>().addNewCategory(category);
              context.pop();
              break;
            case ShowIconDialogWithSelectedIconState():
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => Dialog(
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: CustomIconDialog(
                    alreadySeleced: state.selectedIcon,
                  ),
                ),
              );
              break;
            default:
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create new category',
                style: Fonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppPallete.titleAndSubtitleColor,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              getText("Category name :"),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Form(
                key: categoryForm,
                child: TextFormField(
                  autofocus: true,
                  controller: categoryTitleController,
                  style: Fonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppPallete.whiteColor.withOpacity(0.87),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Category name",
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
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              getText("Category icon :"),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              BlocBuilder<CreateNewCategoryBloc, CreateNewCategoryState>(
                buildWhen: (previous, current) => current is ButtonStates,
                builder: (context, state) {
                  switch (state) {
                    case SuccessSavingSelectedIconState():
                      icon = state.selectedIcon;
                      return FilledButton(
                        style: FilledButton.styleFrom(
                          fixedSize: const Size.fromWidth(42),
                          backgroundColor: AppPallete.chooseIconButtonColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            context.read<CreateNewCategoryBloc>().add(
                                  OnChoosenIconClickedEvent(
                                      selectedIcon: state.selectedIcon),
                                ),
                        child: SvgPicture.asset(
                          state.selectedIcon,
                          // ignore: deprecated_member_use
                          color: AppPallete.whiteColor,
                          height: 24,
                          width: 24,
                        ),
                      );
                    default:
                      return FilledButton(
                        onPressed: () => context
                            .read<CreateNewCategoryBloc>()
                            .add(OnChooseIconButtonClickedEvent()),
                        style: FilledButton.styleFrom(
                            backgroundColor: AppPallete.chooseIconButtonColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            )),
                        child: Text(
                          'Choose icon',
                          style: Fonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppPallete.titleAndSubtitleColor),
                        ),
                      );
                  }
                },
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              getText("Category color :"),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child:
                    BlocBuilder<CreateNewCategoryBloc, CreateNewCategoryState>(
                  buildWhen: (previous, current) => current is ColorStates,
                  builder: (context, state) {
                    switch (state) {
                      case CategoryColorSelectedState():
                        color = listOfColors[state.selectedColor];
                        return colorsList(selectedColor: state.selectedColor);
                      default:
                        return colorsList();
                    }
                  },
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              const Expanded(
                flex: 12,
                child: SizedBox(),
              ),
              Row(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: buttonTextStyle(AppPallete.primaryColorForButton),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (categoryForm.currentState!.validate()) {
                        context.read<CreateNewCategoryBloc>().add(
                              OnSaveNewCategoryEvent(
                                  name: categoryTitleController.text.trim(),
                                  icon: icon,
                                  color: color),
                            );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppPallete.primaryColorForButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Choose Category',
                      style: buttonTextStyle(AppPallete.titleAndSubtitleColor),
                    ),
                  ),
                ],
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text getText(String text) {
    return Text(
      text,
      style: Fonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppPallete.whiteColor.withOpacity(0.87)),
    );
  }

  TextStyle buttonTextStyle(Color color) {
    return Fonts.lato(fontSize: 16, fontWeight: FontWeight.w400, color: color);
  }

  ListView colorsList({int? selectedColor}) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listOfColors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.read<CreateNewCategoryBloc>().add(
                OnColorSelectedEvent(selectedIndex: index),
              ),
          child: selectedColor != null && index == selectedColor
              ? ColorContainerWidget(
                  color: listOfColors[index],
                  selectedColor: selectedColor,
                )
              : ColorContainerWidget(
                  color: listOfColors[index],
                ),
        );
      },
    );
  }
}
