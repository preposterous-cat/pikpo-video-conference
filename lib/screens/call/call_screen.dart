import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/widgets/gradient_background.dart';

class CallScreen extends StatefulWidget {
  final String username;
  const CallScreen({super.key, required this.username});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(child: CallWidget(username: widget.username)),
    );
  }
}
