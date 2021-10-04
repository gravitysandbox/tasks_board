import 'package:flutter/material.dart';

import '../../../domain/model/task_item.dart';

class DissmissTask extends StatefulWidget {
  final Function? deleteTask;
  final Function? completeTask;
  final Function? editTask;
  final TaskItem? task;
  const DissmissTask(
      {Key? key, this.deleteTask, this.task, this.completeTask, this.editTask})
      : super(key: key);

  @override
  State<DissmissTask> createState() => _DissmissTaskState();
}

class _DissmissTaskState extends State<DissmissTask> {
  void completeTask(String id) {
    widget.completeTask!(id);
  }

  void editTask(TaskItem selectedTask) {
    widget.editTask!(selectedTask);
  }

  void deleteTask(String id) {
    widget.deleteTask!(id);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: const EdgeInsets.only(left: 20.0),
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.delete),
        color: Colors.red,
      ),
      onDismissed: (direction) async => deleteTask(widget.task!.id),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(2.0),
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: widget.task!.isComplete
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Container(),
        ),
        title: Text(
          widget.task!.title,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          widget.task!.subtitle,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        onTap: () => completeTask(widget.task!.id),
        onLongPress: () => editTask(widget.task!),
      ),
    );
  }
}
