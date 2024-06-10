import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class TitleDescriptionContainer extends StatelessWidget {
  const TitleDescriptionContainer({super.key, required this.title, required this.description});

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppPallete.primaryScaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/icons/radio_button.svg"),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: Fonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppPallete.titleAndSubtitleColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      description,
                      style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.dotColor,
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
    );
  }
}
