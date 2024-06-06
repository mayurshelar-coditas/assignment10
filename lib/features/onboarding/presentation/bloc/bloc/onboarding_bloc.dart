import 'dart:async';

import 'package:bloc/bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      on<OnNextButtonClickedEvent>(onNextButtonClickedEvent);
      on<OnGetStartedButtonClicked>(onGetStartedButtonClicked);
    });
  }

  FutureOr<void> onNextButtonClickedEvent(
      OnNextButtonClickedEvent event, Emitter<OnboardingState> emit)  {
    if (event.isLastPage) {
      emit(LastPageState());
    } else {
      emit(OneOfFirstTwoPagesState());
    }
  }

  FutureOr<void> onGetStartedButtonClicked(
      OnGetStartedButtonClicked event, Emitter<OnboardingState> emit) {
    print('Navigate to HomeScreen');
    emit(NavigateToHomeScreen());
  }
}
