import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/widgets/gradient_background.dart';
import 'package:pikpo_video_conference/widgets/login_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientBackground(child: LoginWidget()),
    );
  }
}
