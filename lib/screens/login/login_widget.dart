import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/screens/login/login_controller.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

/// Login screen widget
class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final LoginController _controller =
      LoginController(); // Controller for managing login state

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller to free up resources
    super.dispose();
  }

  @override
  void initState() {
    super.initState(); // Initialize state
  }

  /// Clear the username text field
  void _onClearUsername() {
    _controller.usernameController.clear();
  }

  /// Navigate to the call screen with the provided call type and username
  void _routeToCallScreen(CallType type) {
    final usernameText = _controller.usernameController.text;
    if (usernameText.isNotEmpty) {
      Navigator.pushNamed(context, '/call', arguments: <String, dynamic>{
        "username": _controller.usernameController.text,
        "type": type
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 108),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UsernameText(), // Display the "Username" label
          UsernameTextField(
            controller: _controller
                .usernameController, // Bind the text field to the controller
            onClearPressed:
                _onClearUsername, // Handler for clearing the text field
          ),
          ButtonRow(
            on1To1Pressed: () {
              _routeToCallScreen(
                  CallType.oneToOne); // Navigate to 1-1 call screen
            },
            onGroupPressed: () {
              _routeToCallScreen(
                  CallType.group); // Navigate to group call screen
            },
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying a row of buttons for call options
class ButtonRow extends StatelessWidget {
  final VoidCallback on1To1Pressed;
  final VoidCallback onGroupPressed;

  const ButtonRow({
    super.key,
    required this.on1To1Pressed,
    required this.onGroupPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Wrap(
        spacing: 20,
        runSpacing: 9,
        children: [
          ElevatedButton(
            onPressed: on1To1Pressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              fixedSize: const Size(150, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "1-1",
              style: TextStyle(
                  color: AppColors.textColor, fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
            onPressed: onGroupPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              fixedSize: const Size(150, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Group",
              style: TextStyle(
                  color: AppColors.textColor, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

/// TextField widget for entering the username with a clear button
class UsernameTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClearPressed;

  const UsernameTextField({
    super.key,
    required this.controller,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key("usernameTextField"), // Key for testing purposes
      controller: controller, // Bind the controller
      style: const TextStyle(color: AppColors.textColor),
      decoration: InputDecoration(
        hoverColor: Colors.transparent,
        suffixIcon: ElevatedButton(
          key: const Key("clearUsernameButton"), // Key for testing purposes
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            overlayColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
          ),
          onPressed: onClearPressed, // Clear the text field
          child: const Icon(
            Icons.cancel_rounded,
            color: AppColors.textColor,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        border: InputBorder.none,
        hintText: "Your Username",
        hintStyle: const TextStyle(color: AppColors.textVariant, fontSize: 16),
      ),
    );
  }
}

/// Widget for displaying the "Username" label
class UsernameText extends StatelessWidget {
  const UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Username',
      style: TextStyle(
          color: AppColors.textColor,
          fontSize: 28,
          fontWeight: FontWeight.bold),
    );
  }
}
