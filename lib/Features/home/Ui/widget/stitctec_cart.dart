import 'package:flutter/material.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/theme/app_text_stly.dart';

class StitctecCart extends StatelessWidget {
  final List<ModelTask> allTakas;

  const StitctecCart({super.key, required this.allTakas});

  @override
  Widget build(BuildContext context) {
    final totalTasks = allTakas.length;
    final doneTasks = allTakas.where((task) => task.isCompleted).length;
    final inProgressTasks = totalTasks - doneTasks;

    return Card(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StitctecItem(title: 'Task', number: totalTasks),
            StitctecItem(title: 'Done', number: doneTasks),
            StitctecItem(title: 'in progress', number: inProgressTasks),
          ],
        ),
      ),
    );
  }
}

class StitctecItem extends StatelessWidget {
  final String title;
  final int number;
  const StitctecItem({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: AppTextStyle.headline.copyWith(color: Colors.white),
        ),
        SizedBox(height: 13),
        Text(title, style: AppTextStyle.hintline.copyWith(color: Colors.white)),
      ],
    );
  }
}
