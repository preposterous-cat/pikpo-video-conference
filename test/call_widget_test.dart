import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:pikpo_video_conference/screens/call/call_control_widget.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/screens/call/navbar_widget.dart';
import 'package:pikpo_video_conference/screens/call/transcript_widget.dart';
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

    testWidgets('_onSendMessageHandler adds message to chats list',
        (WidgetTester tester) async {
      final livekitService = MockLiveKitService();

      // Build the widget tree
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

      // Access the state of the CallWidget
      final callWidgetState =
          tester.state<CallWidgetState>(find.byType(CallWidget));

      // Access the chat controller
      final chatController = callWidgetState.controller;

      // Set the initial text in the chat controller
      chatController.messageController.text = 'Hello, World!';

      // Call the handler method
      callWidgetState.onMessageHandler();

      // Trigger a rebuild
      await tester.pump();

      // Verify the chats list has one message
      expect(callWidgetState.chats.length, 1);

      // Verify the contents of the message
      final chat = callWidgetState.chats.first;
      expect(chat['username'], 'test_user');
      expect(chat['message'], 'Hello, World!');

      // Verify the time format (hh:mm a)
      final now = DateTime.now();
      final currentTime = DateFormat('hh:mm a').format(now);
      expect(chat['time'], currentTime);

      // Verify the text field is cleared
      expect(chatController.messageController.text, '');
    });

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
