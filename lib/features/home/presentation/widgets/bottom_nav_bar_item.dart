import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
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
        if (label == 'Calendar') {
          print('Table Calendar');
          TableCalendar(
            firstDay: DateTime.now(),
            focusedDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 3, 14),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24, top: 12),
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
      ),
    );
  }
}
