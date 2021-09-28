import 'package:get_it/get_it.dart';

import '../src/domain/bloc/task_bloc.dart';
import '../src/domain/usecases/create_task.dart';
import '../src/domain/usecases/edit_task.dart';
import '../src/domain/usecases/delete_task.dart';
import '../src/domain/usecases/complete_task.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  // Bloc
  locator.registerLazySingleton(
    () => TaskBloc(
      TaskState(
        tasks: [],
        event: TaskEventType.create,
      ),
    ),
  );

  // Usecases
  locator.registerLazySingleton(
    () => CreateTask(
      bloc: locator<TaskBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => CompleteTask(bloc: locator<TaskBloc>()),
  );
  locator.registerLazySingleton(
    () => EditTask(
      bloc: locator<TaskBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => DeleteTask(
      bloc: locator<TaskBloc>(),
    ),
  );
}
