import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/pages/form_page.dart';
import 'package:todo_list/pages/todo_done_page.dart';
import 'package:todo_list/utils/network_manager.dart';
import 'package:todo_list/widgets/item_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  void refreshData() {
    setState(() {
      isLoading = true;
    });

    NetworkManager().getTodoIsDone(true).then((value) {
      totalDone = value.length;
      setState(() {});
    });

    NetworkManager().getTodoIsDone(false).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TodoDonePage(),
                      ),
                    );
                  },
                  child: Text(
                    "Sudah diselesaikan $totalDone",
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
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
                        : ListView.builder(
                            reverse: false,
                            itemBuilder: (context, index) {
                              return ItemWidget(
                                todoItem: todos[index],
                                handleRefresh: refreshData,
                              );
                            },
                            itemCount: todos.length,
                          ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormPage(),
            ),
          );
          refreshData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
