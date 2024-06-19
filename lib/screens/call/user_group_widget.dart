import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:pikpo_video_conference/services/livekit_service.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class UserGroupWidget extends StatelessWidget {
  final List participants;
  final LiveKitService livekitService;
  final Map<String, bool?> micStatus;
  final Map<String, bool?> videoStatus;
  const UserGroupWidget(
      {super.key,
      required this.participants,
      required this.livekitService,
      required this.micStatus,
      required this.videoStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.primaryVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate size based on available space
          double textSize = constraints.maxHeight * 0.07; // 7% of height
          double imageSize = constraints.maxHeight * 0.40; // 40% of height

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
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
                    Text(
                      "You & ${participants.length - 1} participants",
                      style: TextStyle(
                          color: AppColors.highlightColor, fontSize: textSize),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserWidget(
                          participant: participants[0],
                          livekitService: livekitService,
                          micStatus: micStatus,
                          videoStatus: videoStatus,
                          textSize: textSize,
                          imageSize: imageSize),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
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
                      color: Colors.black.withOpacity(
                          0.5), // Mengatur warna dan tingkat opacity
                      width:
                          double.infinity, // Sesuaikan ukuran sesuai kebutuhan
                      height: double.infinity,
                      child: const Icon(
                        Icons.mic_off_outlined,
                        color: AppColors.textColor,
                      ), // Sesuaikan ukuran sesuai kebutuhan
                    ),
                  if (participant['state'] != 'ACTIVE')
                    Container(
                      color: Colors.white.withOpacity(
                          0.5), // Mengatur warna dan tingkat opacity
                      width:
                          double.infinity, // Sesuaikan ukuran sesuai kebutuhan
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                        "Waiting...",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.backgroundColor),
                      ), // Sesuaikan ukuran sesuai kebutuhan
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: textSize * 0.9, // Adjust space between text and image
          ),
          Text(
            participant['identity'],
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: textSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
