// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo/main.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/pages/completed_todo.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/provider/todo_provider.dart';

void main() {
  // Initial app state
  testWidgets("default state", (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    Finder defaultText = find.text("Add a todo with the button below");

    expect(defaultText, findsOneWidget);
  });

  // Completed todo
  testWidgets("completed todos show up on completed page", (tester) async {
    TodoListNotifier notifier = TodoListNotifier(<Todo>[
      Todo(todoId: 0, content: "Write code", completed: true),
    ]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [todoProvider.overrideWith((ref) => notifier)],
        child: const MaterialApp(home: CompletedTodo()),
      ),
    );
    Finder completedText = find.text("Write code");

    expect(completedText, findsOneWidget);
  });

  // Slide and delete todo
  testWidgets("slide and delete a todo", (tester) async {
    TodoListNotifier notifier = TodoListNotifier(<Todo>[
      Todo(todoId: 0, content: "Write code", completed: false),
    ]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [todoProvider.overrideWith((ref) => notifier)],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    Finder completedText = find.text("Write code");

    expect(completedText, findsOneWidget);

    Finder draggableWidget = find.byKey(const ValueKey("0"));
    Finder deleteButton = find.byKey(const ValueKey("0delete"));
    await tester.timedDrag(
      draggableWidget,
      const Offset(200, 0),
      const Duration(seconds: 1),
    );
    await tester.pump();
    await tester.tap(deleteButton);
    await tester.pump();

    Finder defaultText = find.text("Add a todo with the button below");

    expect(defaultText, findsOneWidget);
  });
}
