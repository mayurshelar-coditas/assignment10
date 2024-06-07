import 'package:flutter/material.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/features/home/presentation/widgets/bottom_nav_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.bottomNavBarColor,
      child: const Row(
        children: [
          SizedBox(
            width: 24,
          ),
          BottomNavBarItem(
            iconUrl: 'assets/icons/home_icon.svg',
            label: "Home",
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          BottomNavBarItem(
            iconUrl: 'assets/icons/calendar.svg',
            label: "Calendar",
          ),
          Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          BottomNavBarItem(
            iconUrl: 'assets/icons/clock.svg',
            label: "Focuse",
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          BottomNavBarItem(
            iconUrl: 'assets/icons/user.svg',
            label: "Profile",
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }
}
