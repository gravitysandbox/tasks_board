part of '../bloc/task_bloc.dart';

class TaskState {
  final List<TaskItem> tasks;
  final TaskEventType event;

  TaskState({
    required this.tasks,
    required this.event,
  });

  TaskState createTask(TaskItem createdTask) {
    tasks.add(createdTask);
    return TaskState(tasks: tasks, event: TaskEventType.create);
  }

  TaskState completeTask(String id) {
    var index = tasks.indexWhere((element) => element.id == id);
    tasks[index].isComplete = !tasks[index].isComplete;
    return TaskState(tasks: tasks, event: TaskEventType.complete);
  }

  TaskState editTask(TaskItem editedTask) {
    tasks[tasks.indexWhere((task) => task.id == editedTask.id)] = editedTask;
    return TaskState(tasks: tasks, event: TaskEventType.edit);
  }

  TaskState deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
    return TaskState(tasks: tasks, event: TaskEventType.delete);
  }
}
