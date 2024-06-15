import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikpo_video_conference/screens/call/share_screen_widget.dart';
import 'package:pikpo_video_conference/screens/call/transcript_widget.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';
import 'package:pikpo_video_conference/widgets/custom_dialog_alert.dart';

import 'call_control_widget.dart';
import 'navbar_widget.dart';
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
  bool isChatVisible = false;
  bool isShareScreenActive = false;
  bool isSendMessageActive = false;

  @override
  void initState() {
    super.initState();
  }

  void _onDisconnectRoom() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogAlert(
          title: "Warning",
          content: "Are you sure you want to leave the room?",
          onConfirm: () {
            // Handle confirm action
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          onCancel: () {
            // Handle cancel action
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

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
      isSendMessageActive = !isSendMessageActive;
    });
  }

  void _onShareScreenHandler() {
    setState(() {
      isShareScreenActive = !isShareScreenActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavbarWidget(
                widget: widget,
                onDisconnectPressed: _onDisconnectRoom,
              ),
              if (isShareScreenActive)
                const Flexible(
                  flex: 6,
                  child: ShareScreenWidget(),
                ),
              Flexible(
                flex: !isShareScreenActive && !isTranscriptActive
                    ? 2
                    : 4, //Adjust flex to fit screen based on Share Screen and Transcript
                child: UserListWidget(statusList: {
                  "isMicActive": isMicActive,
                  "isVideoActive": isVideoActive,
                  "isTranscriptActive": isTranscriptActive,
                  "isShareScreenActive": isShareScreenActive
                }),
              ),
              if (isTranscriptActive)
                const Flexible(
                  flex: 5,
                  child: TranscriptWidget(),
                ),
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
                "isSendMessageActive": isSendMessageActive,
                "isShareScreenActive": isShareScreenActive
              })
            ],
          ),
        ),
        _buildChatContainer(),
        _buildSendMessageContainer(),
      ],
    );
  }

  Widget _buildSendMessageContainer() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: isSendMessageActive ? 0 : -400,
      left: 0,
      right: 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -7) {
            setState(() {
              isSendMessageActive = true;
            });
          } else if (details.primaryDelta! > 7) {
            setState(() {
              isSendMessageActive = false;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 22),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: AppColors.textColor,
          ),
          child: Column(
            children: [
              if (!isChatVisible)
                SizedBox(
                  height: 20,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      color: const Color(0xFFDADADA),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.open_in_full_rounded),
                    onPressed: () {
                      setState(() {
                        isChatVisible = !isChatVisible;
                      });
                    },
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Write a message",
                          hintStyle: TextStyle(color: Color(0xFFDBDBDB)),
                          border: InputBorder.none),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.photo_camera_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Handle send message
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.photo_library_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Handle send message
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.compare_arrows_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Handle send message
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                            backgroundColor: const Color(0xFFDADADA)),
                        child: const Icon(
                          Icons.send_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Handle send message
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatContainer() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: isSendMessageActive && isChatVisible ? 0 : -900,
      left: 0,
      right: 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -7) {
            setState(() {
              isSendMessageActive = true;
              isChatVisible = true;
            });
          } else if (details.primaryDelta! > 7) {
            setState(() {
              isSendMessageActive = false;
              isChatVisible = false;
            });
          }
        },
        child: Container(
          height: 500,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: AppColors.textColor,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    color: const Color(0xFFDADADA),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: const Column(
                    children: [
                      UserChat(),
                      UserChat(),
                      UserChat(),
                      UserChat(),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserChat extends StatelessWidget {
  const UserChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.backgroundColor))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            width: 30,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "User",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        ".10:15PM",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      )
                    ],
                  ),
                  Text(
                    "Lorem Ipsum sit dolot amettt Lorem Ipsum sit dolot amettt Lorem Ipsum sit dolot amettt Lorem Ipsum sit dolot amettt",
                    style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontSize: 16,
                        overflow: TextOverflow.clip),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ControlButtonType { mic, video, transcript, chat, sharescreen }

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
