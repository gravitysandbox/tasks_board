import 'dart:developer';

import 'package:dartz/dartz.dart';

import '/src/domain/repositories/database.dart';
import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';
import '../model/task_item.dart';

class EditTask implements UserCase<Either<Failure, bool>, TaskItem> {
  final TaskBloc bloc;
  final DatabaseHelper databaseHelper;

  EditTask({required this.bloc, required this.databaseHelper});

  @override
  Future<Either<Failure, bool>> call(TaskItem editedTask) async {
    log('EditTask() call');
    final databaseRequest = await databaseHelper.editTask(editedTask);
    databaseRequest.fold(
      (l) => log('EditTask() failure: ${l.message}'),
      (r) => bloc.add(
        TaskItemEdit(
          task: editedTask,
        ),
      ),
    );
    return const Right(true);
  }
}
