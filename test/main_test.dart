import 'package:clean_architecture/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:clean_architecture/config/config.dart';

void main() {
  testWidgets('Home page loads correctly', (tester) async {
    // Build our app with providers and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: appProviders,
        child: const CleanApp(),
      ),
    );

    // Verify that the home page loaded correctly (not Dashboard - that's a different route)
    expect(find.text('This is the first page'), findsOneWidget);
  });
}
