import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_board/locator.dart';
import 'package:tasks_board/src/domain/model/usecase.dart';
import 'package:tasks_board/src/domain/usecases/read_tasks.dart';
import 'package:tasks_board/src/features/home/widgets/nothing_to_show.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/usecases/create_task.dart';
import '/src/domain/usecases/complete_task.dart';
import '/src/domain/usecases/edit_task.dart';
import '/src/domain/usecases/delete_task.dart';
import '../widgets/dissmiss_task.dart';
import '../widgets/input_dialog.dart';
import '../../../domain/model/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _createTask() async {
    final createdTask = await showDialog<TaskItem>(
      context: context,
      builder: (_) => const InputDialog(
        isEditing: false,
      ),
    );
    if (createdTask != null) {
      locator<CreateTask>().call(createdTask);
    }
  }

  void _editTask(TaskItem selectedTask) async {
    final editedTask = await showDialog<TaskItem>(
      context: context,
      builder: (_) => InputDialog(
        task: selectedTask,
        isEditing: true,
      ),
    );
    locator<EditTask>().call(editedTask!);
  }

  void _completeTask(String id) {
    locator<CompleteTask>().call(id);
  }

  void _readTasks() {
    locator<ReadTasks>().call(NoParams());
  }

  void _deleteTask(String id) {
    locator<DeleteTask>().call(id);
  }

  SnackBar _buildSnackBar(TaskEventType event) {
    final Map<TaskEventType, String> snackText = {
      TaskEventType.read: 'Refreshed',
      TaskEventType.create: 'Created',
      TaskEventType.complete: 'Completed',
      TaskEventType.edit: 'Edited',
      TaskEventType.delete: 'Deleted',
    };

    return SnackBar(
      content: Text(snackText[event]!),
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_buildSnackBar(state.event));
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tasks Board',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _readTasks,
                        icon: const Icon(Icons.refresh),
                        color: Colors.white,
                      ),
                    ],
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
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: state.tasks.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.grey,
                              ),
                              shrinkWrap: true,
                              itemCount: state.tasks.length,
                              itemBuilder: (context, index) {
                                return DissmissTask(
                                  task: state.tasks[index],
                                  deleteTask: _deleteTask,
                                  completeTask: _completeTask,
                                  editTask: _editTask,
                                );
                              },
                            )
                          : const NothingToShow(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
