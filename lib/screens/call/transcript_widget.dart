import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class TranscriptWidget extends StatelessWidget {
  const TranscriptWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryVariant,
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transcript",
                  style: TextStyle(color: AppColors.textColor),
                ),
                Icon(
                  Icons.open_in_full_rounded,
                  color: AppColors.textColor,
                  size: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
