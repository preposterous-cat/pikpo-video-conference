import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:pikpo_video_conference/screens/call/share_screen_widget.dart';
import 'package:pikpo_video_conference/screens/call/transcript_widget.dart';
import 'package:pikpo_video_conference/screens/call/user_group_widget.dart';
import 'package:pikpo_video_conference/services/livekit_service.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';
import 'package:pikpo_video_conference/widgets/custom_dialog_alert.dart';
import 'package:http/http.dart' as http;

import 'call_control_widget.dart';
import 'navbar_widget.dart';
import 'user_onetoone_widget.dart';

enum CallType { oneToOne, group }

class CallWidget extends StatefulWidget {
  final String username;
  final CallType type;
  final LiveKitService livekitService;

  const CallWidget(
      {super.key,
      required this.username,
      required this.type,
      required this.livekitService});

  @override
  State<CallWidget> createState() => CallWidgetState();
}

class CallWidgetState extends State<CallWidget> {
  // Additional state for each participant
  final Map<String, bool?> micStatus = {};
  final Map<String, bool?> videoStatus = {};
  bool isTranscriptActive = false;
  bool isChatVisible = false;
  bool isShareScreenActive = false;
  bool isSendMessageActive = false;
  bool isPendingConnection = false;
  List participants = [];

  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here

    _getListParticipants();
  }

  Future<void> _getListParticipants() async {
    // Get token
    final serverUrl = dotenv.env['SERVER_URL'];
    final response = await http
        .get(Uri.parse("$serverUrl/api/participant/getListParticipants"));

    if (response.statusCode == 200) {
      setState(() {
        participants = jsonDecode(response.body);
        // Initialize mic and video status for each participant
        for (var participant in participants) {
          micStatus[participant['identity']] = widget
              .livekitService.room.localParticipant?.trackPublications.values
              .firstWhere(
                  (p) => p.participant.identity == participant['identity'])
              .participant
              .isMicrophoneEnabled();
          videoStatus[participant['identity']] = false;
        }
      });
    }
  }

  /// Displays a dialog to confirm room disconnection
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

  /// Toggles microphone state
  void _onMicHandler(String identity) {
    setState(() {
      micStatus[identity] = !micStatus[identity]!;
    });
    // Find the corresponding participant and set microphone enabled/disabled
    final participant = widget
        .livekitService.room.localParticipant?.trackPublications.values
        .firstWhere((p) => p.participant.identity == identity);
    participant?.participant.setMicrophoneEnabled(micStatus[identity]!);
  }

  void _onVideoHandler(String identity) {
    setState(() {
      videoStatus[identity] = !videoStatus[identity]!;
    });
  }

  /// Toggles transcript state
  void _onTranscriptHandler() {
    setState(() {
      isTranscriptActive = !isTranscriptActive;
    });
  }

  /// Toggles chat state
  void _onChatHandler() {
    setState(() {
      isSendMessageActive = !isSendMessageActive;
    });
  }

  /// Toggles share screen state
  void _onShareScreenHandler() {
    setState(() {
      isShareScreenActive = !isShareScreenActive;
    });
  }

  /// get all status state
  Map<String, bool?> getStatusList() {
    return {
      "isMicActive": micStatus[widget.username],
      "isVideoActive": videoStatus[widget.username],
      "isTranscriptActive": isTranscriptActive,
      "isShareScreenActive": isShareScreenActive,
      "isPendingConnection": isPendingConnection,
      "isSendMessageActive": isSendMessageActive,
      "isChatVisible": isChatVisible
    };
  }

  /// get all status state
  Map<String, VoidCallback> getHandlerList() {
    return {
      "onMicPressed": () {
        _onMicHandler(widget.username);
      },
      "onVideoPressed": () {
        _onVideoHandler(widget.username);
      },
      "onTranscriptPressed": _onTranscriptHandler,
      "onChatPressed": _onChatHandler,
      "onShareScreenPressed": _onShareScreenHandler,
    };
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
                    ? UserOnetoOneWidget(
                        participants: participants,
                        livekitService: widget.livekitService,
                      )
                    : UserGroupWidget(statusList: getStatusList()),
              ),
              if (isTranscriptActive)
                const Flexible(
                  flex: 5,
                  child: TranscriptWidget(),
                ),
              CallControlWidget(
                  handlerList: getHandlerList(), statusList: getStatusList())
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
