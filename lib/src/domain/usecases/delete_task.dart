import 'dart:developer';

import 'package:dartz/dartz.dart';

import '/src/domain/repositories/database.dart';
import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';

class DeleteTask extends UserCase<Either<Failure, dynamic>, String> {
  final TaskBloc bloc;
  final DatabaseHelper databaseHelper;

  DeleteTask({required this.bloc, required this.databaseHelper});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    log('DeleteTask() call');
    final databaseRequest = await databaseHelper.deleteTask(params);
    databaseRequest.fold(
      (l) => log('DeleteTask() failure: ${l.message}'),
      (r) => bloc.add(
        TaskItemDelete(
          id: params,
        ),
      ),
    );
    return const Right(true);
  }
}
