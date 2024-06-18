import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

enum ControlButtonType { mic, video, transcript, chat, sharescreen }

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
            key: const Key("micButton"),
            icon: const Icon(
              Icons.mic_none_rounded,
              color: AppColors.textColor,
            ),
            onPressed: handlerList["onMicPressed"],
            type: ControlButtonType.mic,
            isActive: statusList["isMicActive"],
          ),
          ControlButton(
            key: const Key("videoButton"),
            icon: const Icon(
              Icons.videocam_outlined,
              color: AppColors.textColor,
            ),
            onPressed: handlerList["onVideoPressed"],
            type: ControlButtonType.video,
            isActive: statusList["isVideoActive"],
          ),
          ControlButton(
            key: const Key("transcriptButton"),
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
            key: const Key("chatButton"),
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
            key: const Key("shareScreenButton"),
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

class ControlButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final ControlButtonType type;
  final bool isActive;

  const ControlButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.type,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.primaryVariant;
    if (type == ControlButtonType.transcript && isActive) {
      backgroundColor = const Color(0xFFA9C9D5);
    }
    return Stack(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            minimumSize: const Size(50, 50),
            shape: const CircleBorder(),
            backgroundColor: backgroundColor,
          ),
          onPressed: onPressed,
          child: icon,
        ),
        if (type == ControlButtonType.mic && !isActive)
          IgnorePointer(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: CustomPaint(
                painter: DiagonalLinePainter(),
              ),
            ),
          ),
        if (type == ControlButtonType.video && !isActive)
          IgnorePointer(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: CustomPaint(
                painter: DiagonalLinePainter(),
              ),
            ),
          ),
        if (type == ControlButtonType.sharescreen && isActive)
          IgnorePointer(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: CustomPaint(
                painter: DiagonalLinePainter(),
              ),
            ),
          ),
      ],
    );
  }
}

class DiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    // Draw a diagonal line
    canvas.drawLine(
      const Offset(10, 5),
      Offset(size.width / 1.3, size.height / 1.1),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
