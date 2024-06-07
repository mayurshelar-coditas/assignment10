import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/features/home/presentation/pages/home_page.dart';

part 'home_page_route.g.dart';


@TypedShellRoute<HomeRoute>(
  routes: [],
)
class HomeRoute extends ShellRouteData {
  HomeRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => const HomePage();
}
