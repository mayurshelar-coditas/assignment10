import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class FlagTile extends StatelessWidget {
  const FlagTile({super.key, required this.flagId, this.isSelected});

  final String flagId;
  final int? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected != null && flagId == isSelected.toString()
            ? AppPallete.primaryColorForButton
            : AppPallete.calendarDateContainerColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/flag.svg"),
          const SizedBox(
            height: 8,
          ),
          Flexible(
            child: Text(
              flagId,
              style: Fonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppPallete.whiteColor.withOpacity(0.87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
