import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:week_14/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Happy path test', (tester) async {
    app.main();

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('todoField')),
      'Integration Todo',
    );

    await tester.tap(find.byKey(const Key('addButton')));

    await tester.pumpAndSettle();

    expect(find.text('Integration Todo'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));

    await tester.pumpAndSettle();
  });
}
