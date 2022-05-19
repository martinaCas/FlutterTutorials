import 'package:flutter_test/flutter_test.dart';
import 'package:non_material_app/main.dart';

void main() {
  testWidgets('Codelab smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hello World'), findsOneWidget);
  });
}
