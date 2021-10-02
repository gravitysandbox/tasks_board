import 'dart:developer';

import 'package:dartz/dartz.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';
import '/src/domain/repositories/database.dart';

class ReadTasks implements UserCase<Either<Failure, void>, NoParams> {
  final TaskBloc bloc;
  final DatabaseHelper databaseHelper;

  ReadTasks({
    required this.bloc,
    required this.databaseHelper,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    log('ReadItems call');
    final databaseRequest = await databaseHelper.readTasks();
    databaseRequest.fold(
      (l) => log(
        'ReadTask failure: ${l.message}',
      ),
      (r) => bloc.add(
        TaskItemRead(
          tasks: [...r],
        ),
      ),
    );

    return const Right(true);
  }
}
