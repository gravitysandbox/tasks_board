part of '../bloc/task_bloc.dart';

enum TaskEventType {
  create,
  complete,
  edit,
  delete,
}

@immutable
abstract class TaskEvent extends Equatable {
  final TaskEventType type;

  const TaskEvent(this.type, [List props = const []]) : super();
}

class TaskCreate extends TaskEvent {
  final TaskItem task;

  const TaskCreate({required this.task}) : super(TaskEventType.create);

  @override
  List<Object?> get props =>
      [task.id, task.title, task.subtitle, task.isComplete];
}

class TaskComplete extends TaskEvent {
  final String id;

  TaskComplete({required this.id}) : super(TaskEventType.complete, [id]);

  @override
  List<Object?> get props => [id];
}

class TaskEdit extends TaskEvent {
  final TaskItem task;

  TaskEdit({required this.task}) : super(TaskEventType.edit, [task]);

  @override
  List<Object?> get props => [task.id, task.title, task.subtitle];
}

class TaskDelete extends TaskEvent {
  final String id;

  TaskDelete({required this.id}) : super(TaskEventType.delete, [id]);

  @override
  List<Object?> get props => [id];
}
