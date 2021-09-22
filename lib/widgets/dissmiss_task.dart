import 'package:flutter/material.dart';
import 'package:tasks_board/model/task.dart';

class DissmissTask extends StatefulWidget {
  final Function? deleteTask;
  final Function? completeTask;
  final Function? startEditingTask;
  final List<Task>? tasks;
  final int index;
  const DissmissTask(
      {Key? key,
      this.deleteTask,
      this.tasks,
      required this.index,
      this.completeTask,
      this.startEditingTask})
      : super(key: key);

  @override
  State<DissmissTask> createState() => _DissmissTaskState();
}

class _DissmissTaskState extends State<DissmissTask> {
  void deleteTask(int index) {
    widget.deleteTask!(index);
  }

  void completeTask(int index) {
    widget.completeTask!(index);
  }

  void startEditingTask(BuildContext context, Task selectedTask) {
    widget.startEditingTask!(context, selectedTask);
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
      onDismissed: (direction) async => deleteTask(widget.index),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(2.0),
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: widget.tasks![widget.index].isComplete != null &&
                  widget.tasks![widget.index].isComplete! == true
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Container(),
        ),
        title: Text(
          widget.tasks![widget.index].title!,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          widget.tasks![widget.index].subtitle!,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        onTap: () => completeTask(widget.index),
        onLongPress: () =>
            startEditingTask(context, widget.tasks![widget.index]),
      ),
    );
  }
}
