import 'package:flutter/material.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home/presentation/widgets/category_tile.dart';

class CustomCategoryPicker extends StatelessWidget {
  CustomCategoryPicker({super.key});

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Grocery',
      'icon': 'assets/icons/grocery_category_icon.svg',
      'color': AppPallete.groceryCategoryColor
    },
    {
      'name': 'Work',
      'icon': 'assets/icons/work_category_icon.svg',
      'color': AppPallete.workCategoryColor
    },
    {
      'name': 'Sport',
      'icon': 'assets/icons/sports_category_icon.svg',
      'color': AppPallete.sportsCategoryColor
    },
    {
      'name': 'Design',
      'icon': 'assets/icons/design_category_icon.svg',
      'color': AppPallete.designCategoryColor
    },
    {
      'name': 'University',
      'icon': 'assets/icons/university_category_icon.svg',
      'color': AppPallete.universityCategoryColor
    },
    {
      'name': 'Social',
      'icon': 'assets/icons/social_category_icon.svg',
      'color': AppPallete.socialCategoryColor
    },
    {
      'name': 'Music',
      'icon': 'assets/icons/music_category_icon.svg',
      'color': AppPallete.musicCategoryColor
    },
    {
      'name': 'Health',
      'icon': 'assets/icons/health_category_icon.svg',
      'color': AppPallete.healthCategoryColor
    },
    {
      'name': 'Movie',
      'icon': 'assets/icons/movie_category_icon.svg',
      'color': AppPallete.movieCategoryColor
    },
    {
      'name': 'Home',
      'icon': 'assets/icons/home_category_icon.svg',
      'color': AppPallete.homeCategoryColor
    },
    {
      'name': 'Create New',
      'icon': 'assets/icons/add_new_category_icon.svg',
      'color': AppPallete.createNewCategoryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              'Choose Category',
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
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final data = categories[index];
                return CategoryTile(
                  color: data['color'] as Color,
                  icon: data['icon'] as String,
                  name: data['name'] as String,
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppPallete.primaryColorForButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Add Category',
                  style: Fonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppPallete.whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
