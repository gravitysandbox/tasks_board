import 'dart:developer';

import 'package:dartz/dartz.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';
import '/src/domain/repositories/database.dart';
import '../model/task_item.dart';

class CreateTask implements UserCase<Either<Failure, dynamic>, TaskItem> {
  final TaskBloc bloc;
  final DatabaseHelper databaseHelper;

  CreateTask({
    required this.bloc,
    required this.databaseHelper,
  });

  @override
  Future<Either<Failure, bool>> call(TaskItem createdTask) async {
    log('CreateTask() call');
    final databaseRequest = await databaseHelper.createTask(createdTask);
    databaseRequest.fold(
      (l) => log('CreateTask() failure: ${l.message}'),
      (r) => bloc.add(
        TaskItemCreate(
          task: createdTask,
        ),
      ),
    );
    return const Right(true);
  }
}
