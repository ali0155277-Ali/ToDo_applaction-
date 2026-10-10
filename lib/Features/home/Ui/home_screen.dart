import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_day/Features/AddTask/Ui/add_task_screen.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/home/Ui/widget/app_ber_home.dart';
import 'package:to_day/Features/home/Ui/widget/stitctec_cart.dart';
import 'package:to_day/Features/home/Ui/widget/tasks_listvew.dart';
import 'package:to_day/Features/home/data/task_bloc.dart';
import 'package:to_day/Features/home/data/task_event.dart';
import 'package:to_day/Features/home/data/task_state.dart';
import 'package:to_day/core/app_const.dart';
import 'package:to_day/theme/app_text_stly.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const AppBerHome(),
              const SizedBox(height: 20),
              BlocSelector<TaskBloc, TaskState, List<ModelTask>>(
                selector: (state) => state.tasks,
                builder: (context, tasks) => StitctecCart(allTakas: tasks),
              ),
              const SizedBox(height: 20),
              Text("Today's Tasks", style: AppTextStyle.headline),
              const SizedBox(height: 10),
              const TasksListvew(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
        },
        label: Row(
          children: [
            const Icon(Icons.add),
            Text('Add', style: AppTextStyle.hintline),
          ],
        ),
      ),
    );
  }
}
