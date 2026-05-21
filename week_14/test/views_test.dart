import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week_14/controllers/todo_controller.dart';
import 'package:week_14/views/todo_screen.dart';

void main() {
  testWidgets('Add todo using UI', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TodoScreen(
          controller: TodoController(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('todoField')),
      'Learn Testing',
    );

    await tester.tap(find.byKey(const Key('addButton')));

    await tester.pump();

    expect(find.text('Learn Testing'), findsOneWidget);
  });
}
