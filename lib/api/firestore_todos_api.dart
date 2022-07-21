import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/auth_api.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/utils.dart';

class FirebaseTodosApi {
  static Future createTodo(BuildContext context, Todo todo) async {
    final uid = Provider.of<AuthApi>(context, listen: false).getCurrentUid();
    final docTodo = FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('todos').doc();
    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());
  }

  static Stream<List<Todo>> readTodos(BuildContext context) async* {
    final uid = Provider.of<AuthApi>(context, listen: false).getCurrentUid();
    yield* FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('todos')
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson));
  }

  static Future updateTodo(BuildContext context, Todo todo) async {
    final uid = Provider.of<AuthApi>(context, listen: false).getCurrentUid();
    final docTodo = FirebaseFirestore.instance.collection('tasks').doc(uid).collection('todos').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(BuildContext context, Todo todo) async {
    final uid = Provider.of<AuthApi>(context, listen: false).getCurrentUid();
    final docTodo = FirebaseFirestore.instance.collection('tasks').doc(uid).collection('todos').doc(todo.id);

    await docTodo.delete();
  }
}
