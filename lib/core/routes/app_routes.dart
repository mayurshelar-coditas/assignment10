import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:up_todo/core/constants.dart/constant_keys.dart';
import 'package:up_todo/core/routes/onboarding_routes/onboarding_route.dart'
    as onboarding_route;
import 'package:up_todo/core/routes/home_routes/home_route.dart' as home_route;

class AppRoutes {
  static final router = GoRouter(
    routes: [
      ...onboarding_route.$appRoutes,
      ...home_route.$appRoutes,
    ],
    initialLocation: const home_route.HomeRoute().location,
    // routerNeglect: true,
    redirect: (context, state) async {
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        bool isAuthenticated = pref.getBool(ConstantKeys.LOGINKEY) ?? false;
        if (isAuthenticated) {
          return const home_route.HomeRoute().location;
        } else {
          return const onboarding_route.OnboardingRoute().location;
        }
      } catch (e) {
        print(e);
        return const home_route.HomeRoute().location;
      }
    },
  );
}

// routes.dart

// import 'package:go_router/go_router.dart';
// import 'package:my_project/modules/login/login.dart';
// import 'package:my_project/routes/wrapped_routes/wrapped_routes.dart'
//     as wrapped_routes;
// import 'package:my_project/modules/login/login.dart' as login_routes;
// import 'package:my_project/modules/register/register.dart' as register_routes;

// class Routes {
//   static final router = GoRouter(
//     routes: [
//       ...login_routes.$appRoutes,
//       ...register_routes.$appRoutes,
//       ...wrapped_routes.$appRoutes,
//     ],
//     initialLocation: login_routes.LoginRoute().location,
//     routerNeglect: true,
//   );
// }
// The trick here is to import the route file "as something" to use the $appRoutes specifically from that .g file.

// For common routes (without any Shell)
// login_route.dart

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:my_project/modules/login/login.dart';

// part 'login_route.g.dart';

// const loginRoute = '/login';

// @TypedGoRoute<LoginRoute>(path: loginRoute)
// class LoginRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const LoginPage();
//   }
// }
// For a Shell route type, that's my "wrapper" (I named like that, but basically it's a ShellRoute definition):
// wrapped_routes.dart

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:my_project/modules/home/route/home_route.dart';
// import 'package:my_project/modules/wrapper/wrapper.dart';

// part 'wrapped_routes.g.dart';

// @TypedShellRoute<WrapperRouteData>(
//   routes: <TypedRoute<RouteData>>[
//     TypedGoRoute<HomeRouteData>(path: homeRoute),
//   ],
// )
// class WrapperRouteData extends ShellRouteData {
//   const WrapperRouteData();

//   @override
//   Widget builder(
//     BuildContext context,
//     GoRouterState state,
//     Widget navigator,
//   ) {
//     return WrapperPage(child: navigator);
//   }
// }
// And then we can define only the GoRouteData for that route (since the Typed itself goes under the wrapped_routes.dart file:
// home_route.dart

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:my_project/modules/home/home.dart';

// class HomeRouteData extends GoRouteData {
//   const HomeRouteData();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const HomePage();
//   }
// }

// const homeRoute = '/home';