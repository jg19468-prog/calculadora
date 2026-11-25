import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora/app.widget.dart';

void main() {
  testWidgets('Suma 7 + 8 = 15', (WidgetTester tester) async {
    await tester.pumpWidget(const AppWidget());

    await tester.tap(find.text('7'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('8'));
    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('15'), findsOneWidget);
  });
}
