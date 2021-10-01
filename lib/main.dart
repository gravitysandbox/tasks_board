import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_board/locator.dart';

import '/src/domain/bloc/task_bloc.dart';
import '/src/features/home/screens/home_screen.dart';
import 'src/domain/usecases/read_tasks.dart';
import 'src/domain/model/usecase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  Firebase.initializeApp().then((_) {
    locator<ReadTasks>().call(NoParams());
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = locator<TaskBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _taskBloc,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white10,
          primarySwatch: Colors.green,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
