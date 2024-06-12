import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();

  void dispose() {
    usernameController.dispose();
  }
}
