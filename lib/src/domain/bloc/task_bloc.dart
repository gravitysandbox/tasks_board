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
      case TaskCreate:
        {
          var snapshot = event as TaskCreate;
          yield state.createTask(snapshot.task);
          break;
        }
      case TaskComplete:
        {
          var snapshot = event as TaskComplete;
          yield state.completeTask(snapshot.id);
          break;
        }
      case TaskEdit:
        {
          var snapshot = event as TaskEdit;
          yield state.editTask(snapshot.task);
          break;
        }
      case TaskDelete:
        {
          var snapshot = event as TaskDelete;
          yield state.deleteTask(snapshot.id);
          break;
        }
    }
  }
}
