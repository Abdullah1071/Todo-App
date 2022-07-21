import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({super.key});

  static const route = '/AddTodoWidget';

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  bool? _isTitleEmpty;

  void _addTodo() {
    if (_titleController.text.isEmpty) {
      setState(() {
        _isTitleEmpty = true;
      });
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        createdTime: DateTime.now(),
      );
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(context, todo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: 'Todo Tasks',
        middle: Text('Add Todo'),
      ),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                height: 50,
                child: CupertinoTextField(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: _isTitleEmpty == true
                          ? CupertinoColors.systemRed
                          : CupertinoColors.systemGrey,
                    ),
                  ),
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  placeholder: 'Title',
                  placeholderStyle: const TextStyle(
                    color: CupertinoColors.white,
                  ),
                  style: const TextStyle(
                    color: CupertinoColors.white,
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _isTitleEmpty = true;
                      });
                    } else {
                      setState(() {
                        _isTitleEmpty = false;
                      });
                    }
                  },
                ),
              ),
              _isTitleEmpty == true
                  ? Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                      ),
                      child: const Text(
                        'Title should not be empty',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                    )
                  : const SizedBox(),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                height: 150,
                child: CupertinoTextField(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  controller: _descriptionController,
                  placeholder: 'Description',
                  keyboardType: TextInputType.multiline,
                  maxLines: 9,
                  placeholderStyle: const TextStyle(
                    color: CupertinoColors.white,
                  ),
                  style: const TextStyle(
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                width: 100,
                child: CupertinoButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: _addTodo,
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
