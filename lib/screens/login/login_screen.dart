import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/widgets/gradient_background.dart';
import 'package:pikpo_video_conference/screens/login/login_widget.dart';

/// Main Login Screen widget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Scaffold provides the structure for the screen
      body: GradientBackground(
        // GradientBackground provides a gradient background for the screen
        child: LoginWidget(), // The main content of the login screen
      ),
    );
  }
}
