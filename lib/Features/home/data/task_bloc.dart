import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/home/data/task_event.dart';
import 'package:to_day/Features/home/data/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitialState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskStatusEvent>(_onUpdateTaskStatus);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onLoadTasks(LoadTasksEvent event, Emitter<TaskState> emit) {
    emit(TaskLoadedState(tasks: List<ModelTask>.from(event.tasks)));
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) {
    final updatedTasks = [...state.tasks, event.task];
    emit(TaskLoadedState(tasks: updatedTasks));
  }

  void _onUpdateTaskStatus(
    UpdateTaskStatusEvent event,
    Emitter<TaskState> emit,
  ) {
    final updatedTasks = state.tasks.map((task) {
      if (identical(task, event.task)) {
        return event.updatedTask;
      }
      return task;
    }).toList();

    emit(TaskLoadedState(tasks: updatedTasks));
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) {
    final updatedTasks = List<ModelTask>.unmodifiable(
      state.tasks.where((task) => !identical(task, event.task)),
    );

    emit(TaskLoadedState(tasks: updatedTasks));
  }
}
