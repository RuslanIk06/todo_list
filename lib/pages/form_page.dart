import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/utils/network_manager.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  final titelController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titelController,
                decoration: const InputDecoration(hintText: "Titel"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Desc tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final item = TodoItem(
                      title: titelController.text,
                      description: descController.text,
                      isDone: false,
                    );

                    if (item.title.isNotEmpty && item.description.isNotEmpty) {
                      await NetworkManager().postData(item);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Simpan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
