import 'package:flutter/material.dart';

import 'package:todo_list/models/todo_item.dart';

class ItemWidget extends StatelessWidget {
  final TodoItem todoItem;
  const ItemWidget({
    Key? key,
    required this.todoItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todoItem.isDone ? Colors.grey : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
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
                onPressed: () {},
                child: const Icon(Icons.check),
              ),
            const SizedBox(width: 8),
            if (!todoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                child: const Icon(Icons.delete_forever),
              )
          ],
        ),
      ),
    );
  }
}
