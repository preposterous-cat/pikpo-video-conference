import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikpo_video_conference/screens/call/call_widget.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class CallControlWidget extends StatelessWidget {
  final Map<String, dynamic> handlerList;
  final Map<String, dynamic> statusList;

  const CallControlWidget(
      {super.key, required this.handlerList, required this.statusList});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Wrap(
        spacing: 20,
        runSpacing: 8,
        children: [
          ControlButton(
            icon: const Icon(
              Icons.mic_none_rounded,
              color: AppColors.textColor,
            ),
            onPressed: handlerList["onMicPressed"],
            type: ControlButtonType.mic,
            isActive: statusList["isMicActive"],
          ),
          ControlButton(
            icon: const Icon(
              Icons.videocam_outlined,
              color: AppColors.textColor,
            ),
            onPressed: handlerList["onVideoPressed"],
            type: ControlButtonType.video,
            isActive: statusList["isVideoActive"],
          ),
          ControlButton(
            icon: Text(
              "T",
              style: TextStyle(
                  color: statusList["isTranscriptActive"]
                      ? AppColors.backgroundColor
                      : AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            onPressed: handlerList["onTranscriptPressed"],
            type: ControlButtonType.transcript,
            isActive: statusList["isTranscriptActive"],
          ),
          ControlButton(
            icon: SvgPicture.asset(
              'assets/images/sketch.svg', // Path to your SVG
              width: 18,
              height: 18.19,
              color: AppColors.textColor,
            ),
            onPressed: handlerList["onChatPressed"],
            type: ControlButtonType.chat,
            isActive: statusList["isSendMessageActive"],
          ),
          ControlButton(
            icon: const Icon(
              Icons.present_to_all_rounded,
              color: AppColors.textColor,
            ),
            onPressed: handlerList["onShareScreenPressed"],
            type: ControlButtonType.sharescreen,
            isActive: statusList["isShareScreenActive"],
          ),
        ],
      ),
    );
  }
}
