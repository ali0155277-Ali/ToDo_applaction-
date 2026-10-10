import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:to_day/Features/AddTask/Ui/widget/task_color.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/home/data/task_bloc.dart';
import 'package:to_day/Features/home/data/task_event.dart';
import 'package:to_day/core/app_const.dart';
import 'package:to_day/core/custom_app_bottom.dart';
import 'package:to_day/core/custom_filed_file.dart';

import 'package:to_day/theme/app_text_stly.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var fromkay = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  int? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: fromkay,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                CustomFiledFile(
                  name: 'Task Title',
                  hintText: 'Design Login Screen',
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Task is required";
                    }
                  },
                ),
                SizedBox(height: 30),
                CustomFiledFile(
                  name: "Description",
                  hintText: "Task Description",
                  controller: descriptionController,
                  Size: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomFiledFile(
                  name: "Due date",
                  hintText: "Enter the Date",
                  controller: dateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Date is required";
                    }
                  },
                  redonly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2037),
                    ).then((value) {
                      dateController.text = DateFormat(
                        'dd-MM-yyyy',
                      ).format(value ?? DateTime.now());
                    });
                  },
                ),
                SizedBox(height: 20),
                Text("Choose Color", style: AppTextStyle.hintline),
                SizedBox(height: 12),
                TaskColorListViwe(
                  onColorSelected: (selectedColor) {
                    color = selectedColor?.toARGB32();
                  },
                ),

                SizedBox(height: 20),
                CustomAppBottom(
                  title: 'Save Task',
                  onTap: () {
                    if (color == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a color")),
                      );
                      return;
                    }

                    if (fromkay.currentState!.validate() ?? false) {
                      final newTask = ModelTask(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: dateController.text,
                        color: color!,
                      );

                      final bloc = context.read<TaskBloc>();
                      final navigator = Navigator.of(context);

                      Hive.box<ModelTask>(AppConst.taskBox).add(newTask).then((
                        _,
                      ) {
                        if (!mounted) return;

                        bloc.add(AddTaskEvent(task: newTask));
                       
                        navigator.pop();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
