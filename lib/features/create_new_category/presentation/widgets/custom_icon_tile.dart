import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';

class CustomIconTile extends StatelessWidget {
  const CustomIconTile({
    super.key,
    required this.icon,
    this.selectedIcon,
  });

  final String icon;
  final String? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPallete.calendarDateContainerColor,
        border: Border.all(
          color: selectedIcon != null && selectedIcon == icon
              ? AppPallete.whiteColor
              : AppPallete.calendarDateContainerColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: SvgPicture.asset(
        icon,
      ),
    );
  }
}
