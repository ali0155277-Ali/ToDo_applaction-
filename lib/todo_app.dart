import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/home/data/task_bloc.dart';
import 'package:to_day/Features/home/data/task_event.dart';
import 'package:to_day/Features/splach/ui/splach_screen.dart';
import 'package:to_day/core/app_const.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc()
        ..add(
          LoadTasksEvent(
            tasks: Hive.box<ModelTask>(AppConst.taskBox).values.toList(),
          ),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplachScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Oswald',
        ),
      ),
    );
  }
}
