import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_course/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  IconData fabIcon = Icons.edit;
  bool isBottomSheet = false;
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void changeBottomSheetState({required isShow, required icon}) {
    fabIcon = icon;
    isBottomSheet = isShow;
    emit(AppChangeBottomSheetState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      //[2] first database object.
      print('database Created.');
      database
          .execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT, time TEXT,status TEXT)',
          )
          .then(
            (value) => print('table created.'),
          )
          .catchError(
            (error) => print('Error when creating table ${error.toString()}'),
          );
    }, onOpen: (database) {
      //[3] second database object.
      getDataFromDatabase(database);
      print('database opened.');
    }).then((value) {
      database = value; //[1] Main database object.

      emit(AppCreateDatabaseState());
    });
  }

  void insertIntoDatabase(
      {@required String? title,
      @required String? date,
      @required String? time}) async {
    await database!
        .transaction((txn) => txn.rawInsert(
            'insert into tasks(title,date,time,status) values ("$title","$date","$time","new")'))
        .then((value) {
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database!);
      print("$value insert successfully.");
    }).catchError((error) =>
            print('error when inserting new record ${error.toString()}.'));
  }

  void getDataFromDatabase(Database database) {
    emit(AppGetDatabaseLoadingState()); //just to listen for circular.

    newTasks = [];
    archivedTasks = [];
    doneTasks = [];
    //getting database as parameter because [2] and [3] maybe finish before [1].
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    }); //this query is case sensitive.
  }

  void updateData({required String status, required int id}) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database!);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({required int id}) {
    database!.rawUpdate('delete from tasks where id = ?',
        [id]).then((value) {
      getDataFromDatabase(database!);
      emit(AppDeleteDatabaseState());
    });
  }



}
