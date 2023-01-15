import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/utils/network_manager.dart';
import 'package:todo_list/widgets/item_widget.dart';

class TodoDonePage extends StatefulWidget {
  const TodoDonePage({super.key});

  @override
  State<TodoDonePage> createState() => _TodoDonePageState();
}

class _TodoDonePageState extends State<TodoDonePage> {
  List<TodoItem> todos = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodoIsDone(true).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        width: size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todo yang sudah diselesaikan",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todoItem = todos[index];
                  return ItemWidget(todoItem: todoItem, handleRefresh: () {});
                })
          ],
        ),
      ),
    );
  }
}
