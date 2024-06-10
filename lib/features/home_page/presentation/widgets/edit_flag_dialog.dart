import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home_page/presentation/bloc/home_bloc_bloc.dart';
import 'package:up_todo/features/main_screen/presentation/bloc/main_screen_bloc.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/flag_tile.dart';

class EditFlagDialog extends StatelessWidget {
  const EditFlagDialog({super.key});

  final List<String> flags = const [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];

  @override
  Widget build(BuildContext context) {
    int? selectedFlag;
    String? flag;
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
              'Task Priority',
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),

              //instead use consumer as we only wnat to pop or stay as it is.
              child: BlocBuilder<MainScreenBloc, MainScreenState>(
                builder: (context, state) {
                  switch (state) {
                    case SelectedFlagState():
                      selectedFlag = state.selectedFlag;
                      flag = (selectedFlag! + 1).toString();
                      return flagGrids(isSelected: state.selectedFlag + 1);

                    default:
                      return flagGrids();
                  }
                },
              ),
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
                  context
                      .read<HomeBloc>()
                      .add(OnEditFlagButtonClickedEvent(flag: flag));
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

  GridView flagGrids({int? isSelected}) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.1,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16,
      ),
      itemCount: flags.length,
      itemBuilder: (context, index) {
        final data = flags[index];
        return GestureDetector(
          onTap: () {
            context.read<MainScreenBloc>().add(
                  OnFlagSelectedEvent(selectedFlag: index),
                );
          },
          child: isSelected != null
              ? FlagTile(
                  flagId: data,
                  isSelected: isSelected,
                )
              : FlagTile(flagId: data),
        );
      },
    );
  }
}
