import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:pikpo_video_conference/services/livekit_service.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class UserOnetoOneWidget extends StatelessWidget {
  final List participants;
  final LiveKitService livekitService;
  final Map<String, bool?> micStatus;
  final Map<String, bool?> videoStatus;

  const UserOnetoOneWidget(
      {super.key,
      required this.participants,
      required this.livekitService,
      required this.micStatus,
      required this.videoStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Container(
        decoration: BoxDecoration(
          color: participants.any((p) => p["state"] == "PENDING")
              ? AppColors.primaryVariant
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate size based on available space
            double textSize = constraints.maxHeight * 0.1; // 10% of height
            double imageSize = constraints.maxHeight * 0.40; // 40% of height

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildUserWidgets(textSize, imageSize, participants,
                    livekitService, micStatus, videoStatus),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<Widget> _buildUserWidgets(
    double textSize,
    double imageSize,
    List participants,
    LiveKitService livekitService,
    Map<String, bool?> micStatus,
    Map<String, bool?> videoStatus) {
  if (participants.length == 1) {
    return [
      UserWidget(
        participant: participants[0],
        livekitService: livekitService,
        micStatus: micStatus,
        videoStatus: videoStatus,
        textSize: textSize,
        imageSize: imageSize,
      ),
    ];
  } else if (participants.length == 2) {
    return [
      UserWidget(
        participant: participants[0],
        livekitService: livekitService,
        micStatus: micStatus,
        videoStatus: videoStatus,
        textSize: textSize,
        imageSize: imageSize,
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: imageSize * 0.1, // Adjust spacing
          vertical: imageSize * 0.05,
        ),
        child: SvgPicture.asset(
          'assets/images/call.svg', // Path to your SVG
          fit: BoxFit.contain,
          width: textSize,
          height: textSize,
          color: AppColors.highlightColor,
        ),
      ),
      UserWidget(
        participant: participants[1],
        livekitService: livekitService,
        micStatus: micStatus,
        videoStatus: videoStatus,
        textSize: textSize,
        imageSize: imageSize,
      ),
    ];
  } else {
    return [];
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.participant,
    required this.livekitService,
    required this.micStatus,
    required this.videoStatus,
    required this.textSize,
    required this.imageSize,
  });

  final Map<String, dynamic> participant;
  final LiveKitService livekitService;
  final Map<String, bool?> micStatus;
  final Map<String, bool?> videoStatus;
  final double textSize;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    final currentParticipant = livekitService
        .room.localParticipant?.trackPublications.values
        .where((p) => p.participant.identity == participant['identity']);

    bool isMicActive = micStatus[participant['identity']]!;
    bool isVideoActive = videoStatus[participant['identity']]!;

    // var videoTrack =
    //     currentParticipant?.track;
    // }).firstOrNull;
    return Column(
      children: [
        Text(
          participant['identity'],
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: textSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: textSize * 0.9, // Adjust space between text and image
        ),
        SizedBox(
          width: imageSize,
          height: imageSize * 1.7, // Maintain aspect ratio
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(imageSize * 0.5), // Make it circular
            child: Stack(
              fit: StackFit.expand,
              children: [
                isVideoActive
                    ? VideoTrackRenderer(
                        currentParticipant?.firstOrNull?.track as VideoTrack)
                    : Image.asset(
                        'assets/images/blank-profile.png',
                        fit: BoxFit.cover,
                      ),
                if (!isMicActive)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    width: double.infinity,
                    height: double.infinity,
                    child: const Icon(
                      Icons.mic_off_outlined,
                      color: AppColors.textColor,
                    ),
                  ),
                if (participant['state'] != 'ACTIVE')
                  Container(
                    color: Colors.white.withOpacity(0.5),
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      "Waiting...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.backgroundColor),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
