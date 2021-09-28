import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/todo.dart';

final todosProvider = StreamProvider<List<Todo>>((ref) {
  return FirebaseFirestore.instance
      .collection('todos')
      .snapshots()
      .map((query) => query.docs)
      .map((docs) => docs.map((doc) {
            return Todo(
              doc.id,
              doc.get("body") as String,
              doc.get("date") as DateTime,
            );
          }).toList());
});
