import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class CategoryTile extends StatelessWidget {
  const   CategoryTile(
      {super.key, required this.icon, required this.name, required this.color});

  final String icon, name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: SvgPicture.asset(
            icon,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Fonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppPallete.whiteColor.withOpacity(0.87)),
        ),
      ],
    );
  }
}
