import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/home/Ui/widget/task_item.dart';
import 'package:to_day/Features/home/data/task_bloc.dart';
import 'package:to_day/Features/home/data/task_event.dart';
import 'package:to_day/Features/home/data/task_state.dart';
import 'package:to_day/core/app_const.dart';

class TasksListvew extends StatefulWidget {
  const TasksListvew({super.key});

  @override
  State<TasksListvew> createState() => _TasksListvewState();
}

class _TasksListvewState extends State<TasksListvew> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<TaskBloc, TaskState, List<ModelTask>>(
      selector: (state) => state.tasks,
      builder: (context, tasks) {
        if (tasks.isEmpty) {
          return Lottie.asset('assets/icon/no result found.json');
        }

        return Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              if (index >= tasks.length) {
                return const SizedBox.shrink();
              }

              final task = tasks[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < tasks.length - 1 ? 12 : 0,
                ),
                child: Dismissible(
                  key: ValueKey(task.key),
                  background: Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (dismissDirection) {
                    if (dismissDirection == DismissDirection.startToEnd) {
                      Hive.box<ModelTask>(AppConst.taskBox).delete(task.key);
                      context.read<TaskBloc>().add(DeleteTaskEvent(task: task));
                      setState(() {});
                    }
                  },
                  child: TaskItem(task: task),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
