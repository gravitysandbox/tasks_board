import 'package:dartz/dartz.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';
import '../model/task_item.dart';

class CreateTask implements UserCase<Either<Failure, dynamic>, TaskItem> {
  final TaskBloc bloc;

  CreateTask({required this.bloc});

  @override
  Future<Either<Failure, bool>> call(TaskItem createdTask) async {
    bloc.add(
      TaskCreate(
        task: createdTask,
      ),
    );
    return const Right(true);
  }
}
