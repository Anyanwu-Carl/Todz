import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/provider/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: todoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(todoProvider.notifier).addTodo(todoController.text);
                Navigator.pop(context);
              },
              child: Text(
                "Add Todo",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
