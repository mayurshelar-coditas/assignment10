import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home/presentation/widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
        leadingWidth: 88,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/menu_bar.svg'),
          onPressed: () {},
        ),
        title: const Text(
          'Up-ToDo',
        ),
        centerTitle: true,
        titleTextStyle: Fonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppPallete.whiteColor.withOpacity(0.87),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile_image.png'),
            ),
          )
        ],
      ),
      backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppPallete.floatingButtonColor,
        shape: const CircleBorder(),
        
        child: SvgPicture.asset("assets/icons/add.svg"),
      ),
    );
  }
}
