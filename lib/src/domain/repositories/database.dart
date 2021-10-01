import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '/src/domain/model/task_item.dart';
import '/src/domain/model/failure.dart';

class DatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance
    ..settings = const Settings(persistenceEnabled: false);

  Future<Either<Failure, List<TaskItem>>> readTasks() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('tasks').get();
    List<TaskItem> tasks = [];

    if (querySnapshot.docs.isNotEmpty) {
      tasks.addAll(
        querySnapshot.docs.map(
          (query) => TaskItem.fromJson(query.data()),
        ),
      );
    }

    return Right(tasks);
  }

  Future<Either<Failure, bool>> createTask(TaskItem task) async {
    log('Database createTask call');
    try {
      final WriteBatch batch = _firestore.batch();

      batch.set(
        _firestore.collection('tasks').doc(),
        task.toJson(),
      );
      batch.commit();

      return const Right(true);
    } catch (e) {
      log('Database createTask failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }
}
