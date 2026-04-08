import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/provider/todo_provider.dart';

class CompletedTodo extends ConsumerWidget {
  const CompletedTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Display todo list on CompletedTodo
    List<Todo> todos = ref.watch(todoProvider);

    // Check for completed todo list
    List<Todo> completedTodos = todos
        .where((todo) => todo.completed == true)
        .toList();

    // Home UI
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Completed Todos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: completedTodos.length,
        itemBuilder: (context, index) {
          return Slidable(
            // Start slidable button
            startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                // Delete button
                SlidableAction(
                  onPressed: (context) => ref
                      .watch(todoProvider.notifier)
                      .deleteTodo(completedTodos[index].todoId),
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                  icon: Icons.delete,
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: ListTile(title: Text(completedTodos[index].content)),
            ),
          );
        },
      ),
    );
  }
}
