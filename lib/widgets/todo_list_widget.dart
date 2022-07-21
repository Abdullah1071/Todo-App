import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Widgets/todo_widget.dart';
import 'package:todo_app/api/auth_api.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/widgets/add_todo_widget.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({super.key});

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final authApi = Provider.of<AuthApi>(context);
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            padding: EdgeInsetsDirectional.zero,
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                Icons.logout,
                color: CupertinoColors.systemRed,
              ),
              onPressed: () async {
                await authApi.logout();
              },
            ),
            largeTitle: const Text('Todo Tasks'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.add,
                size: 28,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AddTodoWidget.route);
              },
            ),
          ),
        ],
        body: todos.isEmpty
            ? const Center(
                child: Text(
                  'No Todos',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(30, 29, 29, 1),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return TodoWidget(todo: todos[index]);
                  },
                ),
              ),
      ),
    );
  }
}
