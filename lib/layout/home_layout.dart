import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_course/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_course/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_course/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/cubit/cubit.dart';
import 'package:udemy_course/shared/cubit/states.dart';

import '../shared/components/constants.dart';

//1-create database.      (createDatabase())  //createDatabase():called once in the initState().
//2-create tables.        (createDatabase())
//3-open database.        (createDatabase())
//4-insert into database.   (insertIntoDatabase())
//5-get from database.
//6-update in database.
//7-delete from database.

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) return Navigator.pop(context);
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertIntoDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                    // insertIntoDatabase(
                    //   title: titleController.text,
                    //   date: dateController.text,
                    //   time: timeController.text,
                    // ).then((value) {
                    //   Navigator.pop(context);
                    //   cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                    //   //isBottomSheet = false;
                    //   // setState(() {
                    //   //   fabIcon = Icons.edit;
                    //   // });
                    // }).catchError((error) =>
                    //     print('$error while inserting in database.'));
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(10.0)),
                              color: Colors.blue[100],
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultTextFormField(
                                    //Task Title FormField
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Task Title must not be empty.';
                                      }
                                    },
                                    prefixIcon: Icons.title,
                                    label: "Task Title",
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  defaultTextFormField(
                                    //Task Time FormField
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Task Time must not be empty.';
                                      }
                                    },
                                    prefixIcon: Icons.calendar_month_rounded,
                                    label: "Task Time",
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  defaultTextFormField(
                                    //Task Date FormField
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-06-25'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      }).catchError(
                                          (error) => print(error.toString()));
                                    },
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Task Date must not be empty.';
                                      }
                                    },
                                    prefixIcon: Icons.watch_later_rounded,
                                    label: "Task Date",
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            body: state is! AppGetDatabaseLoadingState
                ? cubit.screens[cubit.currentIndex]
                : const Center(child: CircularProgressIndicator()),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Tasks',
                  icon: Icon(Icons.menu),
                ),
                BottomNavigationBarItem(
                  label: 'Done',
                  icon: Icon(Icons.done),
                ),
                BottomNavigationBarItem(
                  label: 'Archive',
                  icon: Icon(Icons.archive),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
