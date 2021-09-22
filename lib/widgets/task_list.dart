import 'package:flutter/material.dart';

import '../widgets/dissmiss_task.dart';
import '../widgets/simple_input_dialog.dart';
import '../model/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  void _createTask() async {
    final createdTask = await showDialog(
      context: context,
      builder: (_) => const SimpleInputDialog(
        isEditing: false,
      ),
    );
    tasks.add(createdTask);
    setState(() {});
  }

  void _editTask(Task selectedTask) async {
    final editedTask = await showDialog<Task>(
      context: context,
      builder: (_) => SimpleInputDialog(
        task: selectedTask,
        isEditing: true,
      ),
    );
    tasks[tasks.indexWhere((e) => e.id == editedTask!.id)] = editedTask!;
    setState(() {});
  }

  void _completeTask(String id) {
    var index = tasks.indexWhere((element) => element.id == id);
    tasks[index].isComplete = !tasks[index].isComplete;
    setState(() {});
  }

  void _deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    setState(() {});
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
                        task: tasks[index],
                        deleteTask: _deleteTask,
                        completeTask: _completeTask,
                        editTask: _editTask,
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
        onPressed: () => _createTask(),
      ),
    );
  }
}
