import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/core/domain/usecases/task_usecases.dart';
import 'package:up_todo/features/main_screen/presentation/bloc/main_screen_bloc.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/add_new_task_modal_bottom_sheet.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/custom_category_picker.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/custom_flag_dailog.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/custom_table_calendar.dart';
import 'package:up_todo/features/main_screen/presentation/widgets/custom_timer_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _HomePageState();
}

class _HomePageState extends State<MainScreen> {
  TextEditingController titleTextEditController = TextEditingController();
  TextEditingController descriptionTextEditController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String? selectedFlag;
  late String? selectedCategory;
  late String? selectedDay;
  late String? time;
  late Color? selectedColor;
  late String? selectedIcon;

  @override
  void dispose() {
    titleTextEditController.dispose();
    descriptionTextEditController.dispose();
    super.dispose();
  }

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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FittedBox(
          child: BlocListener<MainScreenBloc, MainScreenState>(
            listener: (context, state) {
              switch (state) {
                case MainScreenInitial():
                  break;
                case ShowCalendarDialogState():
                  FocusScope.of(context).unfocus();
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => Dialog(
                      insetPadding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: const CustomTableCalendar(),
                    ),
                  );
                  break;
                case ShowAddNewModalSheetState():
                  print("the modal sheet is opened");
                  locator<AddNewTaskModalBottomSheet>().addNewTask(
                    context,
                    titleTextEditController,
                    descriptionTextEditController,
                    formKey,
                  );
                  break;
                case ShowFlagDialogState():
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => Dialog(
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: MediaQuery.of(context).viewInsets.bottom),
                      child: const CustomFlagModalSheet(),
                    ),
                  );
                  break;
                case ShowChooseCategoryDialogState():
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => Dialog(
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: MediaQuery.of(context).viewInsets.bottom),
                      child: CustomCategoryPicker(),
                    ),
                  );
                  break;
                case SelectedFlagState():
                  // selectedFlag = (state.selectedFlag + 1).toString();
                  break;
                case SelectedCategoryState():
                  // selectedCategory = state.selectedCategory;
                  break;
                case SaveDayAndShowTimerDialogState():
                  print(state.selectedDay.trim());
                  selectedDay = state.selectedDay;
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => Dialog(
                      child: CustomTimerDialog(),
                    ),
                  );
                  break;
                case SaveTimeState():
                  print(state.time);
                  time = state.time;
                  break;
                case ErrorSavingTaskState():
                  print('Error saving task');
                  break;
                case SuccessSavingTaskState():
                  Navigator.pop(context);

                  locator<TaskUsecases>().call(
                      titleTextEditController.text,
                      descriptionTextEditController.text,
                      selectedDay!,
                      time!,
                      selectedFlag!,
                      selectedCategory!,
                      selectedColor!,
                      selectedIcon!);
                  break;
                case SuccessSavingCategoryState():
                  selectedCategory = state.selectedCategory;
                  selectedColor = state.selectedColor;
                  selectedIcon = state.selectedIcon;

                  break;
                case ErrorSavingCategoryState():
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ensure having everything selected"),
                    ),
                  );
                  break;
                case SuccessSavingFlagState():
                  selectedFlag = (state.selectedFlag + 1).toString();
                  break;
                case ErrorSavingFlagState():
                  break;
                case SaveTaskState():
                  context.read<MainScreenBloc>().add(
                        OnSaveNewTask(
                          selectedFlag: selectedFlag,
                          selectedCategory: selectedCategory,
                          selectedDay: selectedDay,
                          time: time,
                        ),
                      );
                  break;
              }
            },
            child: FloatingActionButton(
              onPressed: () => context.read<MainScreenBloc>().add(
                    OnAddNewTaskButtonClicked(),
                  ),
              backgroundColor: AppPallete.floatingButtonColor,
              shape: const CircleBorder(),
              child: SvgPicture.asset("assets/icons/add.svg"),
            ),
          ),
        ),
      ),
      body: widget.navigationShell,
    );
  }
}
