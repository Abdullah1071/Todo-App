import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/firestore_todos_api.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/widgets/completed_list_widget.dart';
import 'package:todo_app/widgets/todo_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/HomePage';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.systemBlue,
        activeColor: CupertinoColors.white,
        inactiveColor: CupertinoColors.white.withOpacity(0.7),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return StreamBuilder<List<Todo>>(
              stream: FirebaseTodosApi.readTodos(context),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CupertinoActivityIndicator(
                        color: CupertinoColors.systemGrey,
                        radius: 15,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Something Went Wrong Try later',
                        ),
                      );
                    } else {
                      final todos = snapshot.data;
                      final provider = Provider.of<TodosProvider>(context);
                      provider.setTodos(todos!);
                      return const TodoListWidget();
                    }
                }
              },
            );
          default:
            return const CompletedListWidget();
        }
      },
    );
  }
}
