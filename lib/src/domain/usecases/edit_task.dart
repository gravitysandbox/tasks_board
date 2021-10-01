import 'package:dartz/dartz.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/domain/model/failure.dart';
import '/src/domain/model/usecase.dart';
import '../model/task_item.dart';

class EditTask implements UserCase<Either<Failure, bool>, TaskItem> {
  final TaskBloc bloc;

  EditTask({required this.bloc});

  @override
  Future<Either<Failure, bool>> call(TaskItem editedTask) async {
    bloc.add(
      TaskItemEdit(
        task: editedTask,
      ),
    );
    return const Right(true);
  }
}
