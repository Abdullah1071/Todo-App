import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/show_todo_task_widget.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  void showTodo(BuildContext context, Todo todo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ShowTodoTaskWidget(todo: todo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showTodo(context, widget.todo),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.todo.title.length > 35
                  ? '${widget.todo.title.substring(0, 35)}...'
                  : widget.todo.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.white,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 7,
              ),
              child: Row(
                children: [
                  Text(
                    DateFormat.yMMMMd().format(widget.todo.createdTime),
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 15,
                    ),
                  ),
                  widget.todo.description.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            widget.todo.description.length > 30
                                ? '${widget.todo.description.substring(0, 30).replaceAll('\n', ' ')}...'
                                : widget.todo.description,
                            style: const TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 15,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: const Text(
                            'No additional text',
                            style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const Divider(
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }
}
