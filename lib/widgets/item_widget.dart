import 'package:flutter/material.dart';

import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/utils/network_manager.dart';

class ItemWidget extends StatelessWidget {
  final TodoItem todoItem;
  const ItemWidget({
    Key? key,
    required this.todoItem,
    required this.handleRefresh,
  }) : super(key: key);

  final Function() handleRefresh;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todoItem.isDone ? Colors.grey : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todoItem.title),
                  const SizedBox(height: 5),
                  Text(todoItem.description),
                ],
              ),
            ),
            const SizedBox(height: 5),
            if (!todoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  await NetworkManager().updateData(
                    todoItem.copyWith(isDone: true),
                  );
                  handleRefresh();
                },
                child: const Icon(Icons.check),
              ),
            const SizedBox(width: 8),
            if (!todoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await NetworkManager().deleteData(todoItem);
                  handleRefresh();
                },
                child: const Icon(Icons.delete_forever),
              )
          ],
        ),
      ),
    );
  }
}
