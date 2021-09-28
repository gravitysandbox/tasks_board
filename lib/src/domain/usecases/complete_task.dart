import 'package:dartz/dartz.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';

class CompleteTask extends UserCase<Either<Failure, bool>, String> {
  final TaskBloc bloc;

  CompleteTask({required this.bloc});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    bloc.add(
      TaskComplete(
        id: params,
      ),
    );
    return const Right(true);
  }
}
