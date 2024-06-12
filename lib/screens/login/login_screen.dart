import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/widgets/gradient_background.dart';
import 'package:pikpo_video_conference/screens/login/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientBackground(child: LoginWidget()),
    );
  }
}
