import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/pages/add_todo.dart';
import 'package:todo/pages/completed_todo.dart';
import 'package:todo/provider/todo_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Display todo list on homepage
    List<Todo> todos = ref.watch(todoProvider);

    // Check for active list
    List<Todo> activeTodos = todos
        .where((todo) => todo.completed == false)
        .toList();

    // Check for completed todo list
    List<Todo> completedTodos = todos
        .where((todo) => todo.completed == true)
        .toList();

    // Home UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (context, index) {
          if (activeTodos.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 400.0),
                child: Text(
                  "Add a todo with the button below",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else if (index == activeTodos.length) {
            if (completedTodos.isEmpty) {
              return Container();
            } else {
              return Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompletedTodo(),
                      ),
                    );
                  },
                  child: Text("Completed Todos"),
                ),
              );
            }
          } else {
            return Slidable(
              key: ValueKey(todos[index].todoId.toString()),
              // Start slidable button
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  // Delete button
                  SlidableAction(
                    key: ValueKey("${todos[index].todoId.toString()}delete"),
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .deleteTodo(activeTodos[index].todoId),
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    icon: Icons.delete,
                  ),
                ],
              ),

              // End slidable button
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  // Confirm button
                  SlidableAction(
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .completeTodo(activeTodos[index].todoId),
                    backgroundColor: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
                    icon: Icons.check,
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
                child: ListTile(title: Text(activeTodos[index].content)),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        tooltip: "Add a todo",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodo()),
          );
        },
        child: Icon(Icons.add, fontWeight: FontWeight.bold),
      ),
    );
  }
}
