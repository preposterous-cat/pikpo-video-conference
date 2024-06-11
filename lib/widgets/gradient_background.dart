import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundColor,
            AppColors.backgroundColor,
            Colors.black87
          ],
          begin: Alignment.center,
          end: Alignment.topCenter,
        ),
      ),
      child: child,
    );
  }
}
