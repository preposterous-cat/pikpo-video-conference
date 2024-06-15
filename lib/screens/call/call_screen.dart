import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/widgets/custom_dialog_alert.dart';
import 'package:pikpo_video_conference/widgets/gradient_background.dart';

/// Main screen for the video call
class CallScreen extends StatefulWidget {
  final String username;
  final CallType type;

  /// Constructor for CallScreen, requires username and call type
  const CallScreen({super.key, required this.username, required this.type});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Disable default back navigation
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        // Show confirmation dialog when back button is pressed
        await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogAlert(
              title: "Warning", // Title of the dialog
              content:
                  "Are you sure you want to leave the room?", // Content of the dialog
              onConfirm: () {
                // Navigate to the root route if confirmed
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              onCancel: () {
                // Close the dialog without any action
                Navigator.of(context).pop(false);
              },
            );
          },
        );
      },
      child: Scaffold(
        body: GradientBackground(
          // Background with gradient
          child: CallWidget(
            username: widget.username, // Username passed from previous screen
            type: widget.type, // Call type passed from previous screen
          ),
        ),
      ),
    );
  }
}
