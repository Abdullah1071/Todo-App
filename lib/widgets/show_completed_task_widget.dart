import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';

class ShowCompletedTaskWidget extends StatefulWidget {
  const ShowCompletedTaskWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<ShowCompletedTaskWidget> createState() =>
      _ShowCompletedTaskWidgetState();
}

class _ShowCompletedTaskWidgetState extends State<ShowCompletedTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Completed',
        
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            Icons.pending_outlined,
          ),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: buildActionSheet,
            );
          },
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                DateFormat.yMMMMd().format(widget.todo.createdTime),
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                left: 20,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.todo.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                left: 20,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.todo.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionSheet(BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text(
              'Mark as incomplete',
              style: TextStyle(
                fontSize: 18,
                color: CupertinoColors.white,
              ),
            ),
            onPressed: () {
              final provider =
                  Provider.of<TodosProvider>(context, listen: false);
              provider.toggleTodoStatus(context, widget.todo);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: const Text(
              'Delete',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: () {
              final provider =
                  Provider.of<TodosProvider>(context, listen: false);
              provider.removeTodo(context, widget.todo);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 18,
              color: CupertinoColors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      );
}
