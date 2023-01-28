import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/tasks_archive/archive_task_screen.dart';
import 'package:todo_app/modules/tasks_done/done_task_screen.dart';
import 'package:todo_app/modules/tasks_new/new_task_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/component/component.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/component/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  //For sqfl package
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  // //create database
  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextForm(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  label: 'Task title',
                                  prefix: Icons.title,
                                  validate: ((value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                  }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultTextForm(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  label: 'Task time',
                                  prefix: Icons.watch,
                                  validate: ((value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                  }),
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultTextForm(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  label: 'Task Date',
                                  prefix: Icons.calendar_today,
                                  validate: ((value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                  }),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2024-01-01'),
                                    ).then((value) {
                                      dateController.text = DateFormat()
                                          .add_yMMMd()
                                          .format(value!);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20,
                      )
                      .closed
                      .then((value) {
                    cubit.changebottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changebottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archive',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
            //body: tasks.length == 0 ? Center(child: CircularProgressIndicator()) : screns[currentIndex],

            //Conditional Builder package
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screns[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
