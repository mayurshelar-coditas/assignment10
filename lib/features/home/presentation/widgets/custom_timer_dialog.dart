import 'package:flutter/material.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';

class CustomTimerDialog extends StatelessWidget {
  const CustomTimerDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Choose Time',
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
            height: 20,
          ),
          Row(
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: AppPallete.calendarDateContainerColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 28,
                  overAndUnderCenterOpacity: 0.1,
                  perspective: 0.008,
                  // controller: ,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 13,
                    builder: (BuildContext context, int index) {
                      return Center(
                        child: Text(
                          index <= 9
                              ? '0${index.toString()}'
                              : index.toString(),
                          style: Fonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Text(
                  ":",
                  style: Fonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppPallete.whiteColor),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: AppPallete.calendarDateContainerColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 28,
                  perspective: 0.0008,
                  // controller: ,
                  diameterRatio: 2,
                  overAndUnderCenterOpacity: 0.1,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 59,
                    builder: (BuildContext context, int index) {
                      return Center(
                        child: Text(
                          index <= 9
                              ? '0${index.toString()}'
                              : index.toString(),
                          style: Fonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: AppPallete.calendarDateContainerColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 28,
                  overAndUnderCenterOpacity: 0.1,
                  perspective: 0.0008,
                  // controller: ,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 2,
                    builder: (BuildContext context, int index) {
                      return Center(
                        child: Text(
                          index == 0 ? 'AM' : 'PM',
                          style: Fonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
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
                    Navigator.pop(context);
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) => const Dialog(
                        child: CustomTimerDialog(),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPallete.primaryColorForButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Text(
                      'Save',
                      style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
