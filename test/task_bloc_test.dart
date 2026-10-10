import 'package:flutter_test/flutter_test.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/home/data/task_bloc.dart';
import 'package:to_day/Features/home/data/task_event.dart';
import 'package:to_day/Features/home/data/task_state.dart';

void main() {
  group('TaskBloc', () {
    late TaskBloc bloc;
    late ModelTask task;

    setUp(() {
      bloc = TaskBloc();
      task = ModelTask(
        title: 'Write tests',
        description: 'Add test coverage',
        date: '08-10-2026',
        color: 0xFF42A5F5,
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('loads tasks and keeps them immutable', () async {
      bloc.add(LoadTasksEvent(tasks: [task]));
      await expectLater(bloc.stream, emits(isA<TaskLoadedState>()));

      expect(bloc.state.tasks, [task]);
      expect(bloc.state, isA<TaskLoadedState>());
      expect(bloc.state.tasks.first, same(task));
    });

    test('toggles a task status', () async {
      bloc.add(LoadTasksEvent(tasks: [task]));
      await expectLater(bloc.stream, emits(isA<TaskLoadedState>()));

      bloc.add(
        UpdateTaskStatusEvent(
          task: task,
          updatedTask: task.copyWith(isCompleted: true),
        ),
      );
      await expectLater(
        bloc.stream,
        emits(
          predicate<TaskState>(
            (state) =>
                state is TaskLoadedState && state.tasks.first.isCompleted,
          ),
        ),
      );

      expect(bloc.state.tasks.first.isCompleted, isTrue);
    });

    test('deletes a task', () async {
      final equalTask = ModelTask(
        title: task.title,
        description: task.description,
        date: task.date,
        color: task.color,
      );
      bloc.add(LoadTasksEvent(tasks: [task, equalTask]));
      await expectLater(bloc.stream, emits(isA<TaskLoadedState>()));
      final previousTasks = bloc.state.tasks;

      bloc.add(DeleteTaskEvent(task: task));
      await expectLater(
        bloc.stream,
        emits(
          predicate<TaskState>(
            (state) =>
                state is TaskLoadedState &&
                state.tasks.length == 1 &&
                identical(state.tasks.first, equalTask),
          ),
        ),
      );

      expect(bloc.state.tasks, isNot(same(previousTasks)));
      expect(() => bloc.state.tasks.add(task), throwsUnsupportedError);
    });
  });
}
