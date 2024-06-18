import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pikpo_video_conference/screens/call/call_control_widget.dart';
import 'package:pikpo_video_conference/screens/call/call_screen.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/screens/call/navbar_widget.dart';
import 'package:pikpo_video_conference/screens/call/share_screen_widget.dart';
import 'package:pikpo_video_conference/screens/call/transcript_widget.dart';
import 'package:pikpo_video_conference/screens/call/user_onetoone_widget.dart';
import 'package:pikpo_video_conference/services/livekit_service.dart';
import 'package:mockito/mockito.dart';

// Create a mock LiveKitService
class MockLiveKitService extends Mock implements LiveKitService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Load environment variables
    await dotenv.load(fileName: ".env");
  });

  group('CallWidget Tests', () {
    testWidgets('initial state of CallWidget', (WidgetTester tester) async {
      final livekitService = MockLiveKitService();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CallWidget(
              username: 'test_user',
              type: CallType.oneToOne,
              livekitService: livekitService,
            ),
          ),
        ),
      );

      // Verify NavbarWidget is displayed
      expect(find.byType(NavbarWidget), findsOneWidget);

      // Verify CallControlWidget is displayed
      expect(find.byType(CallControlWidget), findsOneWidget);
    });

    // testWidgets('share screen toggle', (WidgetTester tester) async {
    //   final livekitService = MockLiveKitService();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(
    //         body: CallWidget(
    //           username: 'test_user',
    //           type: CallType.oneToOne,
    //           livekitService: livekitService,
    //         ),
    //       ),
    //     ),
    //   );

    //   // Find and tap the share screen button
    //   final shareScreenButton = find.byKey(Key("shareScreenButton"));
    //   await tester.tap(shareScreenButton);
    //   await tester.pump();

    //   // Verify ShareScreenWidget is displayed
    //   expect(find.byKey(Key("shareScreenWidget")), findsOneWidget);
    // });

    testWidgets('transcript toggle', (WidgetTester tester) async {
      final livekitService = MockLiveKitService();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CallWidget(
              username: 'test_user',
              type: CallType.oneToOne,
              livekitService: livekitService,
            ),
          ),
        ),
      );

      // Find and tap the transcript button
      final transcriptButton = find.byKey(const Key("transcriptButton"));
      await tester.tap(transcriptButton);
      await tester.pump();

      // Verify TranscriptWidget is displayed
      expect(find.byType(TranscriptWidget), findsOneWidget);
    });

    // testWidgets('chat toggle', (WidgetTester tester) async {
    //   final livekitService = MockLiveKitService();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(
    //         body: CallWidget(
    //           username: 'test_user',
    //           type: CallType.oneToOne,
    //           livekitService: livekitService,
    //         ),
    //       ),
    //     ),
    //   );

    //   // Find and tap the chat button
    //   final chatButton = find.byIcon(Icons.chat);
    //   await tester.tap(chatButton);
    //   await tester.pump();

    //   // Verify chat container is displayed
    //   expect(find.byType(UserChat), findsWidgets);
    // });

    testWidgets('disconnect confirmation dialog', (WidgetTester tester) async {
      final livekitService = MockLiveKitService();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CallWidget(
              username: 'test_user',
              type: CallType.oneToOne,
              livekitService: livekitService,
            ),
          ),
        ),
      );

      // Find and tap the disconnect button
      final disconnectButton = find.byKey(const Key("disconnectButton"));
      await tester.tap(disconnectButton);
      await tester.pump();

      // Verify confirmation dialog is displayed
      expect(find.byKey(const Key("alertDialog")), findsOneWidget);

      // Find and tap the cancel button in the dialog
      final cancelButton = find.text('Cancel');
      await tester.tap(cancelButton);
      await tester.pump();

      // Verify the dialog is dismissed
      expect(find.byKey(const Key("alertDialog")), findsNothing);
    });
  });
}
