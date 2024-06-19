import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class TranscriptWidget extends StatelessWidget {
  final VoidCallback onTranscriptExpandPressed;
  const TranscriptWidget({super.key, required this.onTranscriptExpandPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryVariant,
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transcript",
                  style: TextStyle(color: AppColors.textColor),
                ),
                IconButton(
                  onPressed: onTranscriptExpandPressed,
                  icon: const Icon(Icons.open_in_full_rounded),
                  color: AppColors.textColor,
                  iconSize: 20,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserTranscriptWidget(),
                    UserTranscriptWidget(),
                    UserTranscriptWidget(),
                    UserTranscriptWidget(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTranscriptWidget extends StatelessWidget {
  const UserTranscriptWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/blank-profile.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username",
                    style: TextStyle(
                        color: AppColors.highlightColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Paragraph 1: Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w300,
                        overflow: TextOverflow.clip),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
