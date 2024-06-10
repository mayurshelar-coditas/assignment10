import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:up_todo/core/constants.dart/constant_keys.dart';
import 'package:up_todo/features/home_page/presentation/pages/edit_task_details.dart';
import 'package:up_todo/features/main_screen/presentation/pages/create_new_category_page.dart';
import 'package:up_todo/features/main_screen/presentation/pages/main_screen.dart';
import 'package:up_todo/features/home_page/presentation/pages/home.dart';
import 'package:up_todo/features/onboarding/presentation/pages/onboarding_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _home = GlobalKey<NavigatorState>();
// final _createNewCategory = GlobalKey<NavigatorState>();
// final _calendar = GlobalKey<NavigatorState>();
// final _focus = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        try {
          SharedPreferences pref = await SharedPreferences.getInstance();
          bool isAuthenticated = pref.getBool(ConstantKeys.LOGINKEY) ?? false;
          if (isAuthenticated) {
            return '/home';
          } else {
            return '/onboarding';
          }
        } catch (e) {
          print(e);
          return state.namedLocation('home');
        }
      },
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) => MainScreen(
        navigationShell: navigationShell,
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _home,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const Home(),
              name: 'home',
            ),
            // GoRoute(
            //   path: '/editTaskRoute',
            //   builder: (context, state) => const EditTaskDetails(),
            // ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/createNewCategory',
      name: 'createNewCategoryRoute',
      builder: (context, state) => const CreateNewCategoryPage(),
    ),
    GoRoute(
      path: '/editTaskRoute',
      builder: (context, state) => const EditTaskDetails(),
    ),
  ],
);
