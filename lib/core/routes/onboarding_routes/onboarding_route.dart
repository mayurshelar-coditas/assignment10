import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/features/onboarding/presentation/pages/onboarding_screen.dart';

part 'onboarding_route.g.dart';

const onboardingRoute = '/onboardingRoute';

@TypedGoRoute<OnboardingRoute>(path: onboardingRoute)
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingScreen();
}



//Once you make skip and have to make a login screen please refer following code to implement guarded routes and then redirect the use according to stream which is firebase auth services but as of now we will just redirect as per the UI design
// redirect: (BuildContext context, GoRouterState state) async {
//       final bool loggedIn = FirebaseAuth.instance.currentUser != null;
//       final bool loggingIn = state.matchedLocation == LoginPage.route;
//       if (!loggedIn) return LoginPage.route;
//       if (loggingIn) return MainMenuPage.route;
//       // no need to redirect at all
//       return null;
//     },
