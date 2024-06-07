import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home/presentation/widgets/custom_timer_dialog.dart';

class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Material(
      color: Colors.transparent,
      child: Container(
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
            TableCalendar(
              firstDay: now,
              focusedDay: now,
              lastDay: DateTime.utc(2030, 3, 14),
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) => DateFormat.E(locale)
                    .format(date)
                    .substring(0, 3)
                    .toUpperCase(),
                weekdayStyle: Fonts.lato(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppPallete.whiteColor,
                ),
                weekendStyle: Fonts.lato(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppPallete.weekendColor,
                ),
                decoration: BoxDecoration(color: AppPallete.bottomNavBarColor),
              ),
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, date) {
                  String month = DateFormat.MMMM().format(date).toUpperCase();
                  String year = DateFormat.y().format(date);
                  return Column(
                    children: [
                      Text(
                        month,
                        textAlign: TextAlign.center,
                        style: Fonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppPallete.whiteColor),
                      ),
                      Text(
                        year,
                        textAlign: TextAlign.center,
                        style: Fonts.lato(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppPallete.dotColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Divider(
                        thickness: 1,
                        color: AppPallete.borderColor,
                      ),
                    ],
                  );
                },
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextFormatter: (date, locale) {
                  String month =
                      DateFormat.MMMM(locale).format(date).toUpperCase();
                  String year = DateFormat.y(locale).format(date);
                  return '$month\n$year';
                },
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppPallete.whiteColor,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: AppPallete.whiteColor,
                ),
                titleTextStyle: Fonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppPallete.whiteColor,
                ),
                decoration: BoxDecoration(
                  color: AppPallete.bottomNavBarColor,
                ),
              ),
              calendarStyle: CalendarStyle(
                cellMargin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                defaultDecoration: BoxDecoration(
                  color: AppPallete.calendarDateContainerColor,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                todayDecoration: BoxDecoration(
                  color: AppPallete.primaryColorForButton,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      6,
                    ),
                  ),
                ),
                selectedDecoration: BoxDecoration(
                  color: AppPallete.primaryColorForButton,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      6,
                    ),
                  ),
                ),
                defaultTextStyle: Fonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppPallete.whiteColor.withOpacity(0.87),
                ),
                selectedTextStyle: Fonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppPallete.whiteColor.withOpacity(0.87),
                ),
                todayTextStyle: Fonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppPallete.whiteColor.withOpacity(0.87),
                ),
                weekendDecoration: BoxDecoration(
                  color: AppPallete.calendarDateContainerColor,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                weekendTextStyle: Fonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppPallete.whiteColor.withOpacity(0.87),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
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
                    child: Text(
                      'Choose Time',
                      style: Fonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
