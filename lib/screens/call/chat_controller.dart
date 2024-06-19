import 'package:flutter/material.dart';

/// Controller for managing the login state and logic
class ChatController {
  // TextEditingController for handling the message input
  final TextEditingController messageController = TextEditingController();

  /// Dispose method to clean up the controller when it's no longer needed
  void dispose() {
    // Disposes of the TextEditingController to free up resources
    messageController.dispose();
  }
}
