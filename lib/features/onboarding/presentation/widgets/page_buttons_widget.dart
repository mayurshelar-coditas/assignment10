import 'package:flutter/material.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class PageButtonsWidget extends StatelessWidget {
  const PageButtonsWidget(
      {super.key, required this.onNext, required this.onBack});

  final void Function() onNext, onBack;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 24,
        ),
        TextButton(
          onPressed: onBack,
          child: Text(
            'BACK',
            style: Fonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppPallete.onboardingBackAndSkipButtonColor,
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        FilledButton(
          onPressed: onNext,
          style: FilledButton.styleFrom(
            backgroundColor: AppPallete.onboardingNextAndGetStartedButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: Text(
              'NEXT',
              style: Fonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppPallete.whiteColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
      ],
    );
  }
}
