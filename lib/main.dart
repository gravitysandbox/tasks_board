import 'package:flutter/material.dart';

import './widgets/task_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white10,
        primarySwatch: Colors.green,
      ),
      home: const TaskList(),
    );
  }
}
