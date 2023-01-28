import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/tasks_archive/archive_task_screen.dart';
import 'package:todo_app/modules/tasks_done/done_task_screen.dart';
import 'package:todo_app/modules/tasks_new/new_task_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInittialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //index for bottom nav bar
  int currentIndex = 0;
  //for switch between nav
  List<Widget> screns = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];

  //for switch between titles (app bar)
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  //create and open database and create table method
  void createDatabase() async {
    String path = await getDatabasesPath() + '/todo.db';
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('the table has been created');
        }).catchError((error) {
          print('Error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDateFromDatabase(database);
        print('database opened');
      },
    );
    emit(AppCreateDatabaseState());
  }

  //insert into database method
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction(
      (txn) {
        txn
            .rawInsert(
                'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
            .then((value) {
          print("$value Inserted Successfully");
          emit(AppInsertDatabaseState());
          getDateFromDatabase(database);
        }).catchError((error) {
          print('"$error" Error When Inserting New Record');
        });
        return Future.value(null);
      },
    );
  }

  //get data from data base
  void getDateFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      // tasks = value;
      // print(tasks);

      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
        print(element['status']);
      });
      emit(AppGetDatabaseState());
    });
    ;
  }

  // Update some record
  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDateFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  // Delete record
  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDateFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changebottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
