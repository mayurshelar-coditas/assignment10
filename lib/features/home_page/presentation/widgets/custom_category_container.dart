import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class CustomCategoryContainer extends StatelessWidget {
  const CustomCategoryContainer(
      {super.key, required this.category, required this.icon});

  final String category, icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppPallete.bottomNavBarColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            category,
            style: Fonts.lato(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppPallete.dotColor,
            ),
          ),
        ],
      ),
    );
  }
}
