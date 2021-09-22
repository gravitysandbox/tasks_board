import 'package:flutter/material.dart';
import 'package:tasks_board/widgets/dissmiss_task.dart';

import '../widgets/simple_input_dialog.dart';
import '../model/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];
  bool _isEditing = false;

  void _startCreateNewTask(BuildContext context) {
    _isEditing = false;
    showDialog(
      context: context,
      builder: (_) => SimpleInputDialog(
        createTask: _createNewTask,
        isEditing: _isEditing,
      ),
    );
  }

  void _startEditingTask(BuildContext context, Task selectedTask) {
    _isEditing = true;
    showDialog(
      context: context,
      builder: (_) => SimpleInputDialog(
        isEditing: _isEditing,
        task: selectedTask,
        editTask: _editSelectedTask,
      ),
    );
  }

  void _createNewTask(String taskTitle, String taskSubtitle) {
    final newTask = Task(
      title: taskTitle,
      subtitle: taskSubtitle,
    );
    setState(() {
      tasks.add(newTask);
    });
  }

  void _editSelectedTask(
      Task task, String newTaskTitle, String newTaskSubtitle) {
    task.title = newTaskTitle;
    task.subtitle = newTaskSubtitle;
  }

  void _completeTask(int index) {
    setState(() {
      tasks[index].isComplete == false
          ? tasks[index].isComplete = true
          : tasks[index].isComplete = false;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.remove(tasks[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tasks Board',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.78,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return DissmissTask(
                        key: Key(tasks[index].title!),
                        tasks: tasks,
                        index: index,
                        deleteTask: _deleteTask,
                        completeTask: _completeTask,
                        startEditingTask: _startEditingTask,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _startCreateNewTask(context),
      ),
    );
  }
}
