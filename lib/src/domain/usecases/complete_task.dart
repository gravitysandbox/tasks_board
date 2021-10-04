import 'dart:developer';

import 'package:dartz/dartz.dart';

import '/src/domain/repositories/database.dart';
import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';

class CompleteTask extends UserCase<Either<Failure, bool>, String> {
  final TaskBloc bloc;
  final DatabaseHelper databaseHelper;

  CompleteTask({required this.bloc, required this.databaseHelper});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    log('CompleteTask() call');
    final databaseRequest = await databaseHelper.completeTask(params);
    databaseRequest.fold(
      (l) => log('CompleteTask() failure: ${l.message}'),
      (r) => bloc.add(
        TaskItemComplete(
          id: params,
        ),
      ),
    );
    return const Right(true);
  }
}
