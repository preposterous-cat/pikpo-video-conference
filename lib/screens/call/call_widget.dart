import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pikpo_video_conference/screens/call/chat_controller.dart';
import 'package:pikpo_video_conference/screens/call/share_screen_widget.dart';
import 'package:pikpo_video_conference/screens/call/transcript_widget.dart';
import 'package:pikpo_video_conference/screens/call/user_group_widget.dart';
import 'package:pikpo_video_conference/services/livekit_service.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';
import 'package:pikpo_video_conference/widgets/custom_dialog_alert.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'call_control_widget.dart';
import 'navbar_widget.dart';
import 'user_onetoone_widget.dart';

/// Enum that defines the types of calls.
enum CallType { oneToOne, group }

/// Widget that represents a call screen.
class CallWidget extends StatefulWidget {
  final String username;
  final CallType type;
  final LiveKitService livekitService;

  /// Creates a [CallWidget].
  const CallWidget({
    super.key,
    required this.username,
    required this.type,
    required this.livekitService,
  });

  @override
  State<CallWidget> createState() => CallWidgetState();
}

class CallWidgetState extends State<CallWidget> {
  final Map<String, bool?> micStatus = {};
  final Map<String, bool?> videoStatus = {};
  bool isTranscriptActive = false;
  bool isChatVisible = false;
  bool isShareScreenActive = false;
  bool isSendMessageActive = false;
  bool isPendingConnection = false;
  bool isTranscriptExpanded = false;
  List participants = [];
  List<Map<String, String>> chats = [];
  final ChatController controller = ChatController();

  @override
  void initState() {
    super.initState();
    _getListParticipants();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Fetches the list of participants from the server.
  Future<void> _getListParticipants() async {
    final serverUrl = dotenv.env['SERVER_URL'];
    String roomName = 'onetoone';
    if (widget.type == CallType.group) {
      roomName = 'group';
    }
    final response = await http.get(Uri.parse(
        "$serverUrl/api/participant/getListParticipants?room=$roomName"));

    if (response.statusCode == 200) {
      final newParticipants = jsonDecode(response.body);

      setState(() {
        participants = newParticipants;
      });

      setState(() {
        for (var participant in newParticipants) {
          final identity = participant['identity'];
          final currentParticipant = widget
              .livekitService.room.localParticipant?.trackPublications.values
              .where((p) => p.participant.identity == identity);

          micStatus[identity] = currentParticipant!.firstOrNull?.participant
                  .isMicrophoneEnabled() ??
              false;
          videoStatus[identity] = false;
        }
      });
    }
  }

  /// Displays a dialog to confirm room disconnection.
  void _onDisconnectRoom() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogAlert(
          key: const Key("alertDialog"),
          title: "Warning",
          content: "Are you sure you want to leave the room?",
          onConfirm: () async {
            await widget.livekitService.disconnectRoom();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  /// Toggles microphone state for a given participant.
  void _onMicHandler(String identity) {
    setState(() {
      micStatus[identity] = !micStatus[identity]!;
    });

    final currentParticipant = widget
        .livekitService.room.localParticipant?.trackPublications.values
        .where((p) => p.participant.identity == identity);

    currentParticipant!.firstOrNull?.participant
        .setMicrophoneEnabled(micStatus[identity]!);
  }

  /// Toggles video state for a given participant.
  void _onVideoHandler(String identity) {
    setState(() {
      videoStatus[identity] = !videoStatus[identity]!;
    });
  }

  /// Toggles transcript state.
  void _onTranscriptHandler() {
    setState(() {
      isTranscriptActive = !isTranscriptActive;
    });
  }

  /// Toggles chat state.
  void _onChatHandler() {
    setState(() {
      isSendMessageActive = !isSendMessageActive;
    });
  }

  /// Toggles share screen state.
  void _onShareScreenHandler() {
    setState(() {
      isShareScreenActive = !isShareScreenActive;
    });

    final currentParticipant = widget
        .livekitService.room.localParticipant?.trackPublications.values
        .where((p) => p.participant.identity == widget.username);

    currentParticipant!.firstOrNull?.participant
        .setScreenShareEnabled(isShareScreenActive);
  }

  /// Toggles transcript expansion state.
  void onTranscriptExpandHandler() {
    setState(() {
      isTranscriptExpanded = !isTranscriptExpanded;
    });
  }

  /// Returns a map containing the status of various features.
  Map<String, bool?> getStatusList() {
    return {
      "isMicActive": micStatus[widget.username] ?? true,
      "isVideoActive": videoStatus[widget.username] ?? false,
      "isTranscriptActive": isTranscriptActive,
      "isShareScreenActive": isShareScreenActive,
      "isPendingConnection": isPendingConnection,
      "isSendMessageActive": isSendMessageActive,
      "isChatVisible": isChatVisible
    };
  }

  /// Returns a map containing callbacks for various handlers.
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

  /// Handles the sending of a chat message.
  void onMessageHandler() {
    final messageText = controller.messageController.text;
    final now = DateTime.now();
    final currentTime = DateFormat('hh:mm a').format(now);
    final username = widget.username;

    setState(() {
      chats.add(
          {"username": username, "time": currentTime, "message": messageText});
    });

    controller.messageController.clear();
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
                Flexible(
                  flex: 6,
                  child: ShareScreenWidget(
                      key: const Key("shareScreenWidger"),
                      livekitService: widget.livekitService),
                ),
              if (participants.isNotEmpty)
                Flexible(
                  flex: !isShareScreenActive && !isTranscriptActive ? 2 : 4,
                  child: widget.type == CallType.oneToOne
                      ? UserOnetoOneWidget(
                          participants: participants,
                          livekitService: widget.livekitService,
                          micStatus: micStatus,
                          videoStatus: videoStatus,
                        )
                      : UserGroupWidget(
                          participants: participants,
                          livekitService: widget.livekitService,
                          micStatus: micStatus,
                          videoStatus: videoStatus,
                        ),
                ),
              if (isTranscriptActive)
                Flexible(
                  flex: isTranscriptExpanded ? 10 : 5,
                  child: TranscriptWidget(
                    onTranscriptExpandPressed: onTranscriptExpandHandler,
                  ),
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

  /// Builds the container for sending messages.
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
                offset: Offset(5.0, 5.0),
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
                  TextField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                        hintText: "Write a message",
                        hintStyle: TextStyle(color: Color(0xFFDBDBDB)),
                        border: InputBorder.none),
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
                        onPressed: onMessageHandler,
                        child: const Icon(
                          Icons.send_outlined,
                          color: Colors.black,
                        ),
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

  /// Builds the container for displaying chat messages.
  Widget _buildChatContainer() {
    List<Widget> buildChatList() {
      return chats.map((chat) {
        return UserChat(
          username: chat['username']!,
          time: chat['time']!,
          message: chat['message']!,
        );
      }).toList();
    }

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
                  child: Column(
                    children: [
                      ...buildChatList(),
                      const SizedBox(height: 150),
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

/// Widget that represents a single chat message.
class UserChat extends StatelessWidget {
  final String username;
  final String time;
  final String message;

  /// Creates a [UserChat] widget.
  const UserChat({
    super.key,
    required this.username,
    required this.time,
    required this.message,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      )
                    ],
                  ),
                  Text(
                    message,
                    style: const TextStyle(
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
