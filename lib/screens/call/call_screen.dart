import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/widgets/custom_dialog_alert.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogAlert(
              title: "Warning",
              content: "Are you sure you want to leave the room?",
              onConfirm: () {
                Navigator.of(context).pop(true);
              },
              onCancel: () {
                Navigator.of(context).pop(false);
              },
            );
          },
        );
      },
      child: Scaffold(
        body: GradientBackground(child: CallWidget(username: widget.username)),
      ),
    );
  }
}
