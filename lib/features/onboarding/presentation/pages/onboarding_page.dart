import 'package:flutter/widgets.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subTitle});

  final String imageUrl, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 52,
      ),
      child: Column(
        children: [
          Image(
            image: AssetImage(imageUrl),
          ),
          const Expanded(
            flex: 3,
            child: SizedBox(),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Fonts.lato(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppPallete.titleAndSubtitleColor,
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Text(
            textAlign: TextAlign.center,
            subTitle,
            style: Fonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppPallete.titleAndSubtitleColor,
            ),
          ),
          const Expanded(
            flex: 5,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
