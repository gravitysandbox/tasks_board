import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '/src/domain/model/task_item.dart';
import '/src/domain/model/failure.dart';

class DatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance
    ..settings = const Settings(persistenceEnabled: false);

  Future<Either<Failure, List<TaskItem>>> readTasks() async {
    log('Database readTasks() call');
    try {
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
    } catch (e) {
      log('Database readTasks() failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }

  Future<Either<Failure, bool>> createTask(TaskItem task) async {
    log('Database createTask() call');
    try {
      final WriteBatch batch = _firestore.batch();

      batch.set(
        _firestore.collection('tasks').doc(),
        task.toJson(),
      );
      batch.commit();

      return const Right(true);
    } catch (e) {
      log('Database createTask() failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }

  Future<Either<Failure, bool>> editTask(TaskItem task) async {
    log('Database editTask() call');
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('tasks')
          .where('id', isEqualTo: task.id)
          .get();
      final WriteBatch batch = _firestore.batch();

      batch.update(
        querySnapshot.docs.first.reference,
        task.toJson(),
      );
      batch.commit();

      return const Right(true);
    } catch (e) {
      log('Database editTask() failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }

  Future<Either<Failure, bool>> completeTask(String completedId) async {
    log('Database completeTask() call');
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('tasks')
          .where('id', isEqualTo: completedId)
          .get();
      final WriteBatch batch = _firestore.batch();

      batch.update(
        querySnapshot.docs.first.reference,
        {'isComplete': true},
      );

      return const Right(true);
    } catch (e) {
      log('Database completeTask() failure');
      return const Left(CommonFailure('Firestore filure'));
    }
  }

  Future<Either<Failure, bool>> deleteTask(String deletedId) async {
    log('Database deleteTask() call');
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('tasks')
          .where('id', isEqualTo: deletedId)
          .get();
      final WriteBatch batch = _firestore.batch();

      batch.delete(querySnapshot.docs.first.reference);
      batch.commit();

      return const Right(true);
    } catch (e) {
      log('Database deleteTask() failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }
}
