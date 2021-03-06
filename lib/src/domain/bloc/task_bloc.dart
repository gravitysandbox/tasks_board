import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/task_item.dart';

part '../events/task_events.dart';
part '../model/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(TaskState initialState) : super(initialState);

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    switch (event.runtimeType) {
      case TaskItemCreate:
        {
          var snapshot = event as TaskItemCreate;
          yield state.createTask(snapshot.task);
          break;
        }
      case TaskItemRead:
        {
          var snapshot = event as TaskItemRead;
          yield state.readTasks(snapshot.tasks);
          break;
        }
      case TaskItemComplete:
        {
          var snapshot = event as TaskItemComplete;
          yield state.completeTask(snapshot.id);
          break;
        }
      case TaskItemEdit:
        {
          var snapshot = event as TaskItemEdit;
          yield state.editTask(snapshot.task);
          break;
        }
      case TaskItemDelete:
        {
          var snapshot = event as TaskItemDelete;
          yield state.deleteTask(snapshot.id);
          break;
        }
    }
  }
}
