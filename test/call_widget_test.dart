// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:pikpo_video_conference/screens/call/call_control_widget.dart';
// import 'package:pikpo_video_conference/screens/call/call_widget.dart';
// import 'package:pikpo_video_conference/screens/call/navbar_widget.dart';
// import 'package:pikpo_video_conference/screens/call/share_screen_widget.dart';
// import 'package:pikpo_video_conference/screens/call/transcript_widget.dart';
// import 'package:pikpo_video_conference/screens/call/user_onetoone_widget.dart';

// void main() {
//   testWidgets('CallWidget initializes with correct states',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: Scaffold(
//           body: CallWidget(username: 'test_user', type: CallType.oneToOne),
//         ),
//       ),
//     );

//     // Verify initial states
//     expect(find.byType(NavbarWidget), findsOneWidget);
//     expect(find.byType(UserOnetoOneWidget), findsOneWidget);
//     expect(find.byType(CallControlWidget), findsOneWidget);
//     expect(find.byType(ShareScreenWidget), findsNothing);
//     expect(find.byType(TranscriptWidget), findsNothing);
//   });

//   testWidgets('Toggle mic button', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: Scaffold(
//           body: CallWidget(username: 'test_user', type: CallType.oneToOne),
//         ),
//       ),
//     );

//     // Verify initial mic state
//     final CallWidgetState state = tester.state(find.byType(CallWidget));
//     expect(state.isMicActive, isTrue);

//     // Find and tap the mic button
//     final Finder micButton = find.byIcon(Icons.mic);
//     await tester.tap(micButton);
//     await tester.pump();

//     // Verify mic state after toggle
//     expect(state.isMicActive, isFalse);
//   });

//   testWidgets('Toggle video button', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: Scaffold(
//           body: CallWidget(username: 'test_user', type: CallType.oneToOne),
//         ),
//       ),
//     );

//     // Verify initial video state
//     final CallWidgetState state = tester.state(find.byType(CallWidget));
//     expect(state.isVideoActive, isFalse);

//     // Find and tap the video button
//     final Finder videoButton = find.byIcon(Icons.videocam);
//     await tester.tap(videoButton);
//     await tester.pump();

//     // Verify video state after toggle
//     expect(state.isVideoActive, isTrue);
//   });

//   testWidgets('Toggle transcript button', (WidgetTester tester) async {
//     final CallWidget callWidget = CallWidget(
//       username: 'test_user',
//       type: CallType.oneToOne,
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: callWidget,
//         ),
//       ),
//     );

//     // Verify initial transcript state
//     final state = tester.state(find.byType(CallWidget)) as CallWidgetState;
//     expect(state.isTranscriptActive, isFalse);

//     // Find and tap the transcript button
//     final Finder transcriptButton = find.byIcon(Icons.description);
//     await tester.tap(transcriptButton);
//     await tester.pump();

//     // Verify transcript state after toggle
//     expect(state.isTranscriptActive, isTrue);
//   });

//   testWidgets('Toggle chat button', (WidgetTester tester) async {
//     final CallWidget callWidget = CallWidget(
//       username: 'test_user',
//       type: CallType.oneToOne,
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: callWidget,
//         ),
//       ),
//     );

//     // Verify initial chat state
//     final state = tester.state(find.byType(CallWidget)) as CallWidgetState;
//     expect(state.isSendMessageActive, isFalse);

//     // Find and tap the chat button
//     final Finder chatButton = find.byIcon(Icons.chat);
//     await tester.tap(chatButton);
//     await tester.pump();

//     // Verify chat state after toggle
//     expect(state.isSendMessageActive, isTrue);
//   });

//   testWidgets('Toggle share screen button', (WidgetTester tester) async {
//     final CallWidget callWidget = CallWidget(
//       username: 'test_user',
//       type: CallType.oneToOne,
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: callWidget,
//         ),
//       ),
//     );

//     // Verify initial share screen state
//     final state = tester.state(find.byType(CallWidget)) as CallWidgetState;
//     expect(state.isShareScreenActive, isFalse);

//     // Find and tap the share screen button
//     final Finder shareScreenButton = find.byIcon(Icons.screen_share);
//     await tester.tap(shareScreenButton);
//     await tester.pump();

//     // Verify share screen state after toggle
//     expect(state.isShareScreenActive, isTrue);
//   });
// }
