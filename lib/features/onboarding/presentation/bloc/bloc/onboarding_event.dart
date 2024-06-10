part of 'onboarding_bloc.dart';

sealed class OnboardingEvent {}

class OnNextButtonClickedEvent extends OnboardingEvent {
  final bool isLastPage;

  OnNextButtonClickedEvent({required this.isLastPage});
}

class OnGetStartedButtonClicked extends OnboardingEvent {}
