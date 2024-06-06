import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem(
      {super.key, required this.iconUrl, required this.label});

  final String iconUrl, label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(label);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconUrl),
          const SizedBox(
            height: 12,
          ),
          Text(
            label,
            style: Fonts.lato(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppPallete.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
