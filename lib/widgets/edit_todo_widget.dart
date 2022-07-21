import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';

class EditTodoWidget extends StatefulWidget {
  const EditTodoWidget({super.key, required this.todo});

  final Todo todo;

  static const route = '/AddTodoWidget';

  @override
  State<EditTodoWidget> createState() => _EditTodoWidgetState();
}

class _EditTodoWidgetState extends State<EditTodoWidget> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  bool? _isTitleEmpty;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
  }

  void _editTodo() {
    if (_titleController.text.isEmpty) {
      setState(() {
        _isTitleEmpty = true;
      });
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(context,
          widget.todo, _titleController.text, _descriptionController.text);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('Edit Todo'),
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
                  controller: _descriptionController,
                  textAlignVertical: TextAlignVertical.top,
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
                  onPressed: _editTodo,
                  child: const Text(
                    'Save',
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
