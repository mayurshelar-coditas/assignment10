import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.title,
    required this.day,
    required this.time,
    required this.category,
    required this.flag,
    required this.color,
    required this.icon,
  });

  final String title, day, time, category, flag, color, icon;

  @override
  Widget build(BuildContext context) {
    final hexColor = color.replaceAll("Color(", "").replaceAll(")", "");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppPallete.bottomNavBarColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/icons/radio_button.svg"),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: Fonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppPallete.titleAndSubtitleColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            '$day At $time',
                            style: Fonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppPallete.titleAndSubtitleColor,
                            ),
                          ),
                        ),

                        // I want dynamic space here that takes available space how can I do it
                        // const Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 4,
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(hexColor),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        icon,
                        height: 14,
                        width: 14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        category,
                        style: Fonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppPallete.titleAndSubtitleColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppPallete.bottomNavBarColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    border: Border.all(
                      color: AppPallete.primaryColorForButton,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/flag.svg",
                        height: 14,
                        width: 14,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        flag,
                        style: Fonts.lato(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppPallete.titleAndSubtitleColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
