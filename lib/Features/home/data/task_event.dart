import 'package:to_day/Features/AddTask/data/Models/model_task.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {
  final List<ModelTask> tasks;

  LoadTasksEvent({required this.tasks});
}

class AddTaskEvent extends TaskEvent {
  final ModelTask task;

  AddTaskEvent({required this.task});
}

class UpdateTaskStatusEvent extends TaskEvent {
  final ModelTask task;
  final ModelTask updatedTask;

  UpdateTaskStatusEvent({required this.task, required this.updatedTask});
}

class DeleteTaskEvent extends TaskEvent {
  final ModelTask task;

  DeleteTaskEvent({required this.task});
}
