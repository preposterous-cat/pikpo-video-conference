import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/call/share_screen_widget.dart';
import 'package:pikpo_video_conference/screens/call/transcript_widget.dart';
import 'package:pikpo_video_conference/screens/call/user_group_widget.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';
import 'package:pikpo_video_conference/widgets/custom_dialog_alert.dart';

import 'call_control_widget.dart';
import 'navbar_widget.dart';
import 'user_onetoone_widget.dart';

enum CallType { oneToOne, group }

class CallWidget extends StatefulWidget {
  final String username;
  final CallType type;
  const CallWidget({super.key, required this.username, required this.type});

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
  bool isPendingConnection = false;

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
            Navigator.popUntil(context, ModalRoute.withName('/'));
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
                child: widget.type == CallType.oneToOne
                    ? UserOnetoOneWidget(statusList: {
                        "isMicActive": isMicActive,
                        "isVideoActive": isVideoActive,
                        "isTranscriptActive": isTranscriptActive,
                        "isShareScreenActive": isShareScreenActive,
                        "isPendingConnection": isPendingConnection,
                      })
                    : UserGroupWidget(statusList: {
                        "isMicActive": isMicActive,
                        "isVideoActive": isVideoActive,
                        "isTranscriptActive": isTranscriptActive,
                        "isShareScreenActive": isShareScreenActive,
                        "isPendingConnection": isPendingConnection,
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
                    icon: const Icon(Icons.open_in_full_rounded),
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
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
