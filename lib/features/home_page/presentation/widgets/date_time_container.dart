import 'package:flutter/material.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class DateTimeContainer extends StatelessWidget {
  const DateTimeContainer({super.key, required this.date, required this.time});

  final String date, time;

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
      child: Text(
        '$date At $time',
        style: Fonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppPallete.dotColor,
        ),
      ),
    );
  }
}
