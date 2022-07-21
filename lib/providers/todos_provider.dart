import 'package:flutter/cupertino.dart';
import 'package:todo_app/api/firestore_todos_api.dart';
import 'package:todo_app/models/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get completed =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(BuildContext context, Todo todo) => FirebaseTodosApi.createTodo(context, todo);

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void updateTodo(BuildContext context, Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    FirebaseTodosApi.updateTodo(context, todo);
  }

  void removeTodo(BuildContext context, Todo todo) => FirebaseTodosApi.deleteTodo(context, todo);

  void toggleTodoStatus(BuildContext context, Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseTodosApi.updateTodo(context, todo);
  }
}
