import 'package:get_it/get_it.dart';
import 'package:tasks_board/src/domain/repositories/database.dart';
import 'package:tasks_board/src/domain/usecases/read_tasks.dart';

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

  // Repositories
  locator.registerLazySingleton(() => DatabaseHelper());

  // Usecases
  locator.registerLazySingleton(
    () => ReadTasks(
      bloc: locator<TaskBloc>(),
      databaseHelper: locator<DatabaseHelper>(),
    ),
  );

  locator.registerLazySingleton(
    () => CreateTask(
      bloc: locator<TaskBloc>(),
      databaseHelper: locator<DatabaseHelper>(),
    ),
  );

  locator.registerLazySingleton(
    () => CompleteTask(
      bloc: locator<TaskBloc>(),
      databaseHelper: locator<DatabaseHelper>(),
    ),
  );

  locator.registerLazySingleton(
    () => EditTask(
      bloc: locator<TaskBloc>(),
      databaseHelper: locator<DatabaseHelper>(),
    ),
  );

  locator.registerLazySingleton(
    () => DeleteTask(
      bloc: locator<TaskBloc>(),
      databaseHelper: locator<DatabaseHelper>(),
    ),
  );
}
