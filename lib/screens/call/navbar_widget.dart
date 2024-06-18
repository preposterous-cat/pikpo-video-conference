import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget(
      {super.key, required this.widget, required this.onDisconnectPressed});

  final CallWidget widget;
  final VoidCallback onDisconnectPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/blank-profile.png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: const TextStyle(color: AppColors.textColor),
                ),
                const Text(
                  '@your-website.com',
                  style: TextStyle(color: AppColors.textVariant),
                ),
              ],
            )
          ],
        ),
        ElevatedButton(
          key: const Key("disconnectButton"),
          onPressed: onDisconnectPressed,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              fixedSize: const Size(24, 24),
              backgroundColor: Colors.transparent),
          child: const Icon(
            Icons.output,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
