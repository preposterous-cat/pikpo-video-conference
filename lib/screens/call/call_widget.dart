import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

import 'user_list_widget.dart';

class CallWidget extends StatefulWidget {
  final String username;
  const CallWidget({super.key, required this.username});

  @override
  State<CallWidget> createState() => _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget> {
  bool isMicActive = true;
  bool isVideoActive = false;
  bool isTranscriptActive = false;
  bool isChatActive = false;
  bool isShareScreenActive = false;

  void _onMicHandler() {
    setState(() {
      isMicActive = !isMicActive;
    });
  }

  void _onVideoHandler() {
    setState(() {
      isVideoActive = !isVideoActive;
    });
  }

  void _onTranscriptHandler() {
    setState(() {
      isTranscriptActive = !isTranscriptActive;
    });
  }

  void _onChatHandler() {
    setState(() {
      isChatActive = !isChatActive;
    });
  }

  void _onShareScreenHandler() {
    setState(() {
      isShareScreenActive = !isShareScreenActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavbarWidget(widget: widget),
          // const Flexible(
          //   flex: 6,
          //   child: ShareScreenWidget(),
          // ),
          Flexible(
            flex: 4,
            child: UserListWidget(stateList: {"isMicActive": isMicActive}),
          ),
          // const Flexible(
          //   flex: 5,
          //   child: TranscriptWidget(),
          // ),
          CallControlWidget(handlerList: {
            "onMicPressed": _onMicHandler,
            "onVideoPressed": _onVideoHandler,
            "onTranscriptPressed": _onTranscriptHandler,
            "onChatPressed": _onChatHandler,
            "onShareScreenPressed": _onShareScreenHandler,
          }, statusList: {
            "isMicActive": isMicActive,
            "isVideoActive": isVideoActive,
            "isTranscriptActive": isTranscriptActive,
            "isChatActive": isChatActive,
            "isShareScreenActive": isShareScreenActive
          })
        ],
      ),
    );
  }
}

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
                  fontWeight: FontWeight.w600),
            ),
            onPressed: handlerList["onTranscriptPressed"],
            type: ControlButtonType.transcript,
            isActive: statusList["isTranscriptActive"],
          ),
          ControlButton(
            icon: SvgPicture.asset(
              'assets/images/sketch.svg', // Path to your SVG
              width: 18,
              height: 14.19,
              color: AppColors.textColor,
            ),
            onPressed: handlerList["onChatPressed"],
            type: ControlButtonType.chat,
            isActive: statusList["isChatActive"],
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
        if (type == ControlButtonType.sharescreen && !isActive)
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

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({
    super.key,
    required this.widget,
  });

  final CallWidget widget;

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
          onPressed: () {},
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
