import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/home/data/task_bloc.dart';
import 'package:to_day/Features/home/data/task_event.dart';
import 'package:to_day/Features/home/data/task_state.dart';
import 'package:to_day/core/app_const.dart';
import 'package:to_day/theme/app_text_stly.dart';

class TaskItem extends StatelessWidget {
  final ModelTask task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskColor = Color(task.color);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showTaskDetails(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  color: taskColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(task.title, style: AppTextStyle.headline),
                    Text(task.description, style: AppTextStyle.bodyText),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: taskColor.withValues(alpha: 0.4),
                      ),
                      child: Text(
                        task.date,
                        style: AppTextStyle.hintline.copyWith(color: taskColor),
                      ),
                    ),
                  ],
                ),
              ),
              if (task.isCompleted) const Icon(Icons.check, size: 30, color: Color(0xFF42A5F5)),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context) {
    final taskKey = task.key;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final currentTask = state.tasks.firstWhere(
              (candidate) => candidate.key == taskKey,
              orElse: () => task,
            );
            final taskColor = Color(currentTask.color);

            return Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                24 + MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: SizedBox(
                      width: 48,
                      child: Divider(thickness: 4, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentTask.title,
                    style: AppTextStyle.headline.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(currentTask.description, style: AppTextStyle.bodyText),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: taskColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(currentTask.date, style: AppTextStyle.hintline),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () async {
                            final box = Hive.box<ModelTask>(AppConst.taskBox);
                            final updatedTask = currentTask.copyWith(
                              isCompleted: !currentTask.isCompleted,
                            );
                            final bloc = context.read<TaskBloc>();

                            await box.put(taskKey, updatedTask);
                            bloc.add(
                              UpdateTaskStatusEvent(
                                task: currentTask,
                                updatedTask: updatedTask,
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            foregroundColor: taskColor,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (currentTask.isCompleted) ...[
                                Icon(Icons.check, color: currentTask.isCompleted ? Colors.white : taskColor),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                currentTask.isCompleted
                                    ? 'Completed'
                                    : 'Mark Completed',
                                style: TextStyle(color: taskColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () async {
                      final box = Hive.box<ModelTask>(AppConst.taskBox);
                      final bloc = context.read<TaskBloc>();
                      final navigator = Navigator.of(bottomSheetContext);
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Delete Task'),
                          content: Text(
                            'Delete "${currentTask.title}"? This action cannot be undone.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirmed != true) return;

                      await box.delete(taskKey);
                      bloc.add(DeleteTaskEvent(task: currentTask));
                      if (bottomSheetContext.mounted) navigator.pop();
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete Task'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
