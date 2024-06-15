import 'package:flutter/material.dart';

/// Controller for managing the login state and logic
class LoginController {
  // TextEditingController for handling the username input
  final TextEditingController usernameController = TextEditingController();

  /// Dispose method to clean up the controller when it's no longer needed
  void dispose() {
    // Disposes of the TextEditingController to free up resources
    usernameController.dispose();
  }
}
