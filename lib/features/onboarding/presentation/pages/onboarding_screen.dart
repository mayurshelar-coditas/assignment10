import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:up_todo/core/constants.dart/constant_keys.dart';
import 'package:up_todo/core/routes/home_routes/home_route.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/onboarding/presentation/bloc/bloc/onboarding_bloc.dart';
import 'package:up_todo/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:up_todo/features/onboarding/presentation/widgets/last_page_buttons_widgets.dart';
import 'package:up_todo/features/onboarding/presentation/widgets/page_buttons_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingPage> pages = const [
    OnboardingPage(
      imageUrl: 'assets/images/onboarding_image_one.png',
      title: "Manage your tasks",
      subTitle:
          "You can easily manage all of your daily tasks in DoMe for free",
    ),
    OnboardingPage(
      imageUrl: 'assets/images/onboarding_image_two.png',
      title: "Create daily routine",
      subTitle:
          "In Uptodo you can create your personalized routine to stay productive",
    ),
    OnboardingPage(
      imageUrl: 'assets/images/onboarding_image_three.png',
      title: "Organize your tasks",
      subTitle:
          "You can organize your daily tasks by adding your tasks into separate categories",
    )
  ];
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('State Rebuilt');
    OnboardingBloc onboardingBloc = OnboardingBloc();
    return Scaffold(
      backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 24,
            child: TextButton(
              onPressed: _onSkip,
              child: Text(
                'SKIP',
                style: Fonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppPallete.onboardingBackAndSkipButtonColor,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 40,
            ),
            child: PageView(
              onPageChanged: (index) => onboardingBloc.add(
                OnNextButtonClickedEvent(
                  isLastPage: (index == pages.length - 1),
                ),
              ),
              controller: _controller,
              children: pages,
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: _controller,
              count: pages.length,
              effect: SlideEffect(
                dotColor: AppPallete.dotColor,
                activeDotColor: AppPallete.whiteColor.withOpacity(0.87),
                dotHeight: 4,
                dotWidth: 26,
              ),
              onDotClicked: (index) => _controller.animateToPage(
                index,
                duration: const Duration(microseconds: 350),
                curve: Curves.easeIn,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: BlocConsumer<OnboardingBloc, OnboardingState>(
              bloc: onboardingBloc,
              listenWhen: (context, state) {
                return state is ActionState;
              },
              buildWhen: (context, state) {
                return state is! ActionState;
              },
              builder: (context, state) {
                switch (state) {
                  case LastPageState():
                    return LastPageButtonsWidgets(
                        onGetStarted: _onGetStarted, onBack: _onBack);
                  case OneOfFirstTwoPagesState():
                    return PageButtonsWidget(onNext: _onNext, onBack: _onBack);
                  default:
                    return PageButtonsWidget(onNext: _onNext, onBack: _onBack);
                }
              },
              listener: (BuildContext context, OnboardingState state) {
                switch (state as ActionState) {
                  case NavigateToHomeScreen():
                    const HomeRoute().replace(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  //Methods to change the page based on the controllers.
  void _onSkip() => _controller.jumpToPage(pages.length);

  void _onNext() => _controller.nextPage(
      duration: const Duration(milliseconds: 350), curve: Curves.easeIn);

  Future<void> _onGetStarted(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(ConstantKeys.LOGINKEY, true);
    const HomeRoute().replace(context);
  }

  void _onBack() => _controller.previousPage(
      duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
}
