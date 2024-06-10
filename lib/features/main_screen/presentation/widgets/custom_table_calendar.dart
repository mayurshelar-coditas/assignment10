import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/main_screen/presentation/bloc/main_screen_bloc.dart';

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({
    super.key,
  });

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  DateTime? _selectedDay;
  DateTime? _focusedDay = DateTime.now();

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
              focusedDay: _focusedDay!,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
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
                cellMargin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                defaultDecoration:
                    decoration(AppPallete.calendarDateContainerColor),
                todayDecoration: decoration(AppPallete.goldenColor),
                selectedDecoration:
                    decoration(AppPallete.primaryColorForButton),
                defaultTextStyle:
                    textStyle(12, AppPallete.whiteColor.withOpacity(0.87)),
                selectedTextStyle:
                    textStyle(12, AppPallete.whiteColor.withOpacity(0.87)),
                todayTextStyle:
                    textStyle(12, AppPallete.whiteColor.withOpacity(0.87)),
                weekendDecoration:
                    decoration(AppPallete.calendarDateContainerColor),
                weekendTextStyle:
                    textStyle(12, AppPallete.whiteColor.withOpacity(0.87)),
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
                      style: textStyle(16, AppPallete.primaryColorForButton),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_selectedDay != null) {
                        DateTime dateOnly = DateTime(_selectedDay!.year,
                            _selectedDay!.month, _selectedDay!.day);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(dateOnly);
                        FocusScope.of(context).unfocus();
                        Navigator.maybePop(context);

                        context.read<MainScreenBloc>().add(
                              OnDaySelectedEvent(
                                selectedDay: formattedDate,
                              ),
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please Select Date"),
                          ),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppPallete.primaryColorForButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Choose Time',
                      style: textStyle(16, AppPallete.whiteColor),
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

  _onDaySelected(selectedDay, focusedDay) {
    print(selectedDay);
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  BoxDecoration decoration(Color color) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.all(
        Radius.circular(6),
      ),
    );
  }

  TextStyle textStyle(double fontSize, Color color) {
    return Fonts.lato(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }
}
