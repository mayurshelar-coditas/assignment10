import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/domain/usecases/category_usecases.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home_page/presentation/bloc/home_bloc_bloc.dart';
import 'package:up_todo/features/main_screen/presentation/bloc/main_screen_bloc.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/category_tile.dart';

class EditCategoryDialog extends StatelessWidget {
  const EditCategoryDialog({super.key});

  

  @override
  Widget build(BuildContext context) {
    String? selectedCategory, selectedIcon;
    Color? selectedColor;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppPallete.bottomNavBarColor,
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Choose Category',
              style: Fonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppPallete.whiteColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: AppPallete.borderColor,
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
                switch (state) {
                  case SelectedCategoryState():
                    selectedCategory = state.selectedCategory;
                    selectedColor = state.color;
                    selectedIcon = state.icon;
                    return categoryGrid(
                        selectedCategory: state.selectedCategory);
                  default:
                    return categoryGrid();
                }
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Fonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppPallete.primaryColorForButton,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              FilledButton(
                onPressed: () {
                  context.read<HomeBloc>().add(OnEditCategoryButtonClickedEvent(
                      color: selectedColor,
                      icon: selectedIcon,
                      category: selectedCategory));
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppPallete.primaryColorForButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  child: Text(
                    'Edit',
                    style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  StreamBuilder categoryGrid({String? selectedCategory}) {
    return StreamBuilder(
      stream: locator<CategoryUsecases>().getCategorie(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.active) {
          if (snapshots.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
              ),
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshots.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    if (data['name'] == 'Create New') {
                      context.push('/createNewCategory');
                    } else {
                      context.read<MainScreenBloc>().add(
                            OnCategorySelectedEvent(
                              selectedCategory: data['name'],
                              color: Color(
                                  int.parse(data['color'])), // data['color'],
                              icon: data['icon'],
                            ),
                          );
                    }
                  },
                  child: selectedCategory != null &&
                          selectedCategory == data['name']
                      ? CategoryTile(
                          color: Color(int.parse(
                              data['color'])), //data['color'] as Color,
                          icon: data['icon'],
                          name: data['name'],
                          selectedName: selectedCategory,
                        )
                      : CategoryTile(
                          color: Color(int.parse(
                              data['color'])), //data['color'] as Color,
                          icon: data['icon'],
                          name: data['name'],
                        ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                snapshots.error.toString(),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
