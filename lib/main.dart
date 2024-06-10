import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/routes/app_routes.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/features/create_new_category/presentation/bloc/create_new_category_bloc.dart';
import 'package:up_todo/features/home_page/presentation/bloc/home_bloc_bloc.dart';
import 'package:up_todo/features/main_screen/presentation/bloc/main_screen_bloc.dart';
import 'package:up_todo/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenBloc>(
          create: (context) => MainScreenBloc(),
        ),
        BlocProvider<CreateNewCategoryBloc>(
          create: (context) => CreateNewCategoryBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp.router(
        color: AppPallete.bottomNavBarColor,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
