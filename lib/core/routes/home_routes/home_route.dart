import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/features/home/presentation/pages/home_page.dart';

part 'home_route.g.dart';

const homeRoute = '/home';

@TypedGoRoute<HomeRoute>(path: homeRoute)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
