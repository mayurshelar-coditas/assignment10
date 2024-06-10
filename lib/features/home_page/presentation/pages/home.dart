import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:up_todo/core/di/di_container.dart';
import 'package:up_todo/core/domain/usecases/task_usecases.dart';
import 'package:up_todo/core/themes/app_pallete.dart';
import 'package:up_todo/core/themes/fonts.dart';
import 'package:up_todo/features/home_page/presentation/bloc/home_bloc_bloc.dart';
import 'package:up_todo/features/home_page/presentation/widgets/task_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    return Scaffold(
      backgroundColor: AppPallete.primaryScaffoldBackgroundColor,
      body: Column(
        children: [
          Visibility(
            visible: isVisible,
            replacement: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Image(
                    image: AssetImage("assets/images/visibility_image.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "What do you want to do today?",
                    textAlign: TextAlign.center,
                    style: Fonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppPallete.titleAndSubtitleColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Tap + to add your tasks",
                    style: Fonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppPallete.titleAndSubtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            child: BlocListener<HomeBloc, HomeState>(
              listenWhen: (previous, current) => current is HomeActionableState,
              listener: (context, state) {
                switch (state) {
                  case NavigateToEditTaskScreen():
                    context.push('/editTaskRoute');
                    break;
                  case ListIsEmptyState():
                    isVisible = false;
                    break;
                  default:
                    break;
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchBar(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (state) {
                          return AppPallete.searchBarColor;
                        },
                      ),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      textStyle: WidgetStateProperty.resolveWith<TextStyle>(
                        (states) {
                          return Fonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppPallete.dotColor);
                        },
                      ),
                      leading: SvgPicture.asset("assets/icons/search_icon.svg"),
                      padding: WidgetStateProperty.resolveWith<EdgeInsets>(
                        (state) {
                          return const EdgeInsets.symmetric(horizontal: 12);
                        },
                      ),
                      side: WidgetStateProperty.resolveWith<BorderSide>(
                          (states) => BorderSide(
                                color: AppPallete.borderColor,
                                width: 0.8,
                              )),
                      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                        (state) {
                          return const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          );
                        },
                      ),
                      hintText: 'Search for your task...',
                      hintStyle: WidgetStateProperty.resolveWith<TextStyle>(
                        (states) {
                          return Fonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppPallete.dotColor);
                        },
                      ),
                    ),
                    // ExpansionPanelList(
                    //   expansionCallback: (panelIndex, isExpanded) {},
                    //   children: [
                    //     ExpansionPanel(
                    //       canTapOnHeader: true,
                    //       backgroundColor:
                    //           AppPallete.primaryScaffoldBackgroundColor,
                    //       headerBuilder: (BuildContext context, bool isExpanded) {
                    //         return FilledButton(
                    //           onPressed: () {},
                    //           child: const Text('Today'),
                    //         );
                    //       },
                    //       // body: ListView.builder(
                    //       //   shrinkWrap: true,
                    //       //   itemCount: _items.length,
                    //       //   itemBuilder: (BuildContext context, int index) {
                    //       //     return ListTile(
                    //       //       title: Text(_items[index]),
                    //       //     );
                    //       //   },
                    //       // ),
                    //       body: const Text("Hiiii"),
                    //       isExpanded: false,
                    //     ),
                    //   ],
                    // ),
                    StreamBuilder(
                      stream: locator<TaskUsecases>().callForTask(),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.active) {
                          if (snapshots.hasData) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshots.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var task = snapshots.data!.docs[index];

                                  return GestureDetector(
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                            OnTaskClickedForEditingEvent(
                                              id: task.id,
                                              title: task["title"],
                                              description: task["description"],
                                              day: task["date"],
                                              time: task["time"],
                                              flag: task["flag"],
                                              category: task["category"],
                                              icon: task["icon"],
                                            ),
                                          );
                                    },
                                    child: TaskWidget(
                                      title: task["title"],
                                      day: task["date"],
                                      time: task["time"],
                                      category: task["category"],
                                      flag: task["flag"],
                                      color: task["color"].toString(),
                                      icon: task["icon"],
                                    ),
                                  );
                                },
                              ),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
