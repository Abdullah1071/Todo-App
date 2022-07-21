import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/widgets/completed_widget.dart';

class CompletedListWidget extends StatefulWidget {
  const CompletedListWidget({super.key});

  @override
  State<CompletedListWidget> createState() => _CompletedListWidgetState();
}

class _CompletedListWidgetState extends State<CompletedListWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final completed = provider.completed;
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const CupertinoSliverNavigationBar(
            padding: EdgeInsetsDirectional.zero,
            largeTitle: Text('Completed'),
          ),
        ],
        body: completed.isEmpty
            ? const Center(
                child: Text(
                  'No Tasks Completed',
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
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: completed.length,
                  itemBuilder: (context, index) {
                    return CompletedWidget(todo: completed[index]);
                  },
                ),
              ),
      ),
    );
  }
}
