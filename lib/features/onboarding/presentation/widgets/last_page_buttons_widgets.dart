import 'package:flutter/material.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class LastPageButtonsWidgets extends StatelessWidget {
  const LastPageButtonsWidgets(
      {super.key, required this.onGetStarted, required this.onBack});

  final Future<void> Function(BuildContext context) onGetStarted;
  final void Function() onBack;

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
          onPressed: () async {
              return await onGetStarted(context);
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppPallete.onboardingNextAndGetStartedButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Text(
              'GET STARTED',
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
