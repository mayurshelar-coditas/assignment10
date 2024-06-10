import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/create_new_category/presentation/bloc/create_new_category_bloc.dart';
import 'package:up_todo/features/create_new_category/presentation/widgets/custom_icon_tile.dart';

class CustomIconDialog extends StatelessWidget {
  const CustomIconDialog({super.key, this.alreadySeleced});

  final List<String> icons = const [
    "assets/icons/health_category_icon.svg",
    "assets/icons/grocery_category_icon.svg",
    "assets/icons/design_category_icon.svg",
    "assets/icons/movie_category_icon.svg",
    "assets/icons/music_category_icon.svg",
    "assets/icons/sports_category_icon.svg",
    "assets/icons/social_category_icon.svg",
    "assets/icons/university_category_icon.svg",
    "assets/icons/work_category_icon.svg",
  ];

  final String? alreadySeleced;

  @override
  Widget build(BuildContext context) {
    String? selectedIcon;
    return Container(
      padding: const EdgeInsets.all(8),
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
              'Choose icon',
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
            height: 15,
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),

              //instead use consumer as we only wnat to pop or stay as it is.
              child: BlocBuilder<CreateNewCategoryBloc, CreateNewCategoryState>(
                builder: (context, state) {
                  switch (state) {
                    case SelectedIconState():
                      selectedIcon = state.selectedIcon;
                      return iconGrid(selectedIcon: selectedIcon);

                    default:
                      return iconGrid();
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
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
                  flex: 2,
                  child: SizedBox(),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<CreateNewCategoryBloc>().add(
                        OnIconSaveButtonClickedEvent(
                            selectedIcon: selectedIcon));
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPallete.primaryColorForButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Text(
                      'Save',
                      style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GridView iconGrid({String? selectedIcon}) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 16,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final data = icons[index];
        return GestureDetector(
          onTap: () {
            context
                .read<CreateNewCategoryBloc>()
                .add(OnIconSelectedEvent(selectedIcon: data));
          },
          child: selectedIcon != null && data == selectedIcon
              ? CustomIconTile(
                  icon: data,
                  selectedIcon: selectedIcon,
                )
              : alreadySeleced != null && data == alreadySeleced
                  ? CustomIconTile(
                      icon: data,
                      selectedIcon: alreadySeleced,
                    )
                  : CustomIconTile(icon: data),
        );
      },
    );
  }
}
