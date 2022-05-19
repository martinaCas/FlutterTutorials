import 'package:flutter_test/flutter_test.dart';
import 'package:layouts_flutter/main.dart';
import 'package:layouts_flutter/main.dart';

void main() {
  testWidgets('Codelab smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hello World'), findsOneWidget);
  });
}
