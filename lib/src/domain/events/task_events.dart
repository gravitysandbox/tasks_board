part of '../bloc/task_bloc.dart';

enum TaskEventType {
  read,
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

class TaskItemRead extends TaskEvent {
  final List<TaskItem> tasks;

  TaskItemRead({required this.tasks}) : super(TaskEventType.read, [tasks]);

  @override
  List<Object?> get props => tasks;
}

class TaskItemCreate extends TaskEvent {
  final TaskItem task;

  const TaskItemCreate({required this.task}) : super(TaskEventType.create);

  @override
  List<Object?> get props =>
      [task.id, task.title, task.subtitle, task.isComplete];
}

class TaskItemComplete extends TaskEvent {
  final String id;

  TaskItemComplete({required this.id}) : super(TaskEventType.complete, [id]);

  @override
  List<Object?> get props => [id];
}

class TaskItemEdit extends TaskEvent {
  final TaskItem task;

  TaskItemEdit({required this.task}) : super(TaskEventType.edit, [task]);

  @override
  List<Object?> get props => [task.id, task.title, task.subtitle];
}

class TaskItemDelete extends TaskEvent {
  final String id;

  TaskItemDelete({required this.id}) : super(TaskEventType.delete, [id]);

  @override
  List<Object?> get props => [id];
}
