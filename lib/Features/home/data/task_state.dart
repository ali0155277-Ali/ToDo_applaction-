import 'package:to_day/Features/AddTask/data/Models/model_task.dart';

abstract class TaskState {
  final List<ModelTask> tasks;

  const TaskState({this.tasks = const []});
}

class TaskInitialState extends TaskState {
  const TaskInitialState();
}

class TaskLoadedState extends TaskState {
  const TaskLoadedState({required super.tasks});
}
