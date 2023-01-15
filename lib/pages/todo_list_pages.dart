import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todo List",
                  style: textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sudah diselesaikan $totalDone",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: todos.isEmpty
                        ? const Center(
                            child: Text("tidak ada data"),
                          )
                        : const SizedBox(),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
