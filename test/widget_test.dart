import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';

void main() {
  testWidgets('MyHealthTrackerApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyHealthTrackerApp());

    // Verify that the AppBar title and Patient Profile appear
    expect(find.text('Patient Profile'), findsWidgets);
    expect(find.text('Personal Information'), findsOneWidget);
  });
}
