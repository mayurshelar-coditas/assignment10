part of 'onboarding_bloc.dart';

sealed class OnboardingState {}

sealed class ActionState extends OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class LastPageState extends OnboardingState {}

final class OneOfFirstTwoPagesState extends OnboardingState {}

final class NavigateToHomeScreen extends ActionState {}
