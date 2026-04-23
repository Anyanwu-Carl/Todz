import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/provider/todo_provider.dart';

void main() {
  late ProviderContainer container;
  late TodoListNotifier notifier;
  setUp(() {
    container = ProviderContainer();
    notifier = container.read(todoProvider.notifier);
  });

  // Initial state
  test('todo list starts empty', () {
    expect(notifier.debugState, []);
  });

  // Add todo
  test('add todo', () {
    notifier.addTodo("read a book");
    expect(notifier.debugState[0].content, "read a book");
  });

  // Delete todo
  test('delete todo', () {
    notifier.addTodo("read a book");
    expect(notifier.debugState[0].content, "read a book");

    notifier.deleteTodo(0);
    expect(notifier.debugState, []);
  });

  // Completed todo
  test('completed todo', () {
    notifier.addTodo("read a book");
    expect(notifier.debugState[0].content, "read a book");
    expect(notifier.debugState[0].completed, false);

    notifier.completeTodo(0);
    expect(notifier.debugState[0].completed, true);
  });
}
