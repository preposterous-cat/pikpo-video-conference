import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pikpo_video_conference/screens/login/login_screen.dart';

void main() {
  group('LoginWidget Test', () {
    testWidgets('Username text render correctly', (WidgetTester tester) async {
      //Build the LoginWidget
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      //Verify Usename text are present
      expect(find.text("Username"), findsOneWidget);
    });

    testWidgets("Username Textfield shows input correctly",
        (WidgetTester tester) async {
      //Build the LoginWidget
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      //Find TextField by Key
      final usernameTextField = find.byKey(const Key('usernameTextField'));

      //Enter text into TextField
      await tester.enterText(usernameTextField, "testingUsername");

      // Rebuild the widget with the new state
      await tester.pump();

      // Verify the text has been entered correctly
      expect(find.text("testingUsername"), findsOneWidget);
    });

    testWidgets('Clear button works correctly', (WidgetTester tester) async {
      // Build the LoginWidget
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Find the TextField and clear button
      final usernameTextField = find.byKey(const Key('usernameTextField'));
      final clearButton = find.byIcon(Icons.cancel_rounded);

      // Enter text into the TextField
      await tester.enterText(usernameTextField, 'testuser');

      // Rebuild the widget with the new state
      await tester.pump();

      // Tap the clear button
      await tester.tap(clearButton);

      // Rebuild the widget with the new state
      await tester.pump();

      // Verify the text has been cleared
      expect(find.text('testuser'), findsNothing);
    });

    testWidgets('Buttons render correctly', (WidgetTester tester) async {
      // Build the LoginWidget
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Verify the buttons are present
      expect(find.text('1-1'), findsOneWidget);
      expect(find.text('Group'), findsOneWidget);
    });
  });
}
