import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week_14/main.dart';

void main() {
  testWidgets('Should allow user to insert target list entities seamlessly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(); // Handle internal async simulation initial trace

    // Locate active input component selectors
    final inputField = find.byKey(const Key('todo_input_field'));
    final actionButton = find.byKey(const Key('todo_add_button'));

    expect(inputField, findsOneWidget);

    // Act: Type text content targets and trigger validation button
    await tester.enterText(inputField, 'Refactor performance hooks pipeline');
    await tester.tap(actionButton);
    await tester.pump(); // Advance rendering framework processing updates

    // Assert: UI renders element item targets cleanly
    expect(find.text('Refactor performance hooks pipeline'), findsOneWidget);
  });
}
