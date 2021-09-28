import 'package:dartz/dartz.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';

class DeleteTask extends UserCase<Either<Failure, dynamic>, String> {
  final TaskBloc bloc;

  DeleteTask({required this.bloc});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    bloc.add(
      TaskDelete(
        id: params,
      ),
    );
    return const Right(true);
  }
}
