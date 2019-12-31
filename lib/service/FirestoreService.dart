import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/model/Task.dart';

class FirestoreService {
  String uid;
  final databaseReference = Firestore.instance;
  Map tasks;

  FirestoreService({this.uid});

  Future<DocumentSnapshot> _getDocument() async {
    return await databaseReference.collection(uid).document('tasks').get();
  }

  Future<List<Task>> getTaskList() async {
    if (tasks == null) {
      await _getDocument().then((value) {
        if (value.exists)
          tasks = value.data;
        else
          tasks = {};
      });
    }
    return _convertMapToListTask();
  }

  List<Task> _convertMapToListTask() {
    if (tasks.length == 0) return [];
    List<Task> list = [];
    tasks.forEach((k, v) {
      list.add(TaskBuilder().from(k, v).build());
    });
    return list;
  }

  void deleteTask(String id) async {
    await databaseReference
        .collection(uid)
        .document('tasks')
        .updateData({id: FieldValue.delete()}).whenComplete(() {
      print('Deleted field with id: $id');
    });
  }

  void addTask(Task task) async {
    await databaseReference
        .collection(uid)
        .document('tasks')
        .setData(getMapFromTask(task), merge: true);
  }

  void updateTask(Task task) {
    try {
      databaseReference
          .collection(uid)
          .document('tasks')
          .updateData(getMapFromTask(task));
    } catch (e) {
      print(e.toString());
    }
  }

  Map<String, Map<String, dynamic>> getMapFromTask(Task task) {
    return {
      task.id: {
        'task': task.task,
        'year': task.date.year,
        'month': task.date.month,
        'day': task.date.day,
        'finished': task.finished
      }
    };
  }
}
