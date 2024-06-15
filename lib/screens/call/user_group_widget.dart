import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class UserGroupWidget extends StatelessWidget {
  final Map<String, dynamic> statusList;
  const UserGroupWidget({super.key, required this.statusList});

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
                      "You & 6 participants",
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
                          name: "Arizli R",
                          isMicActive: statusList['isMicActive'],
                          isVideoActive: statusList['isVideoActive'],
                          isPendingConnection: false,
                          textSize: textSize,
                          imageSize: imageSize),
                      UserWidget(
                          name: "Arizli R",
                          isMicActive: statusList['isMicActive'],
                          isVideoActive: statusList['isVideoActive'],
                          isPendingConnection:
                              statusList['isPendingConnection'],
                          textSize: textSize,
                          imageSize: imageSize),
                      UserWidget(
                          name: "Arizli R",
                          isMicActive: statusList['isMicActive'],
                          isVideoActive: statusList['isVideoActive'],
                          isPendingConnection:
                              statusList['isPendingConnection'],
                          textSize: textSize,
                          imageSize: imageSize),
                      UserWidget(
                          name: "Arizli R",
                          isMicActive: statusList['isMicActive'],
                          isVideoActive: statusList['isVideoActive'],
                          isPendingConnection:
                              statusList['isPendingConnection'],
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
    required this.name,
    required this.isMicActive,
    required this.isVideoActive,
    required this.isPendingConnection,
    required this.textSize,
    required this.imageSize,
  });

  final double textSize;
  final double imageSize;
  final String name;
  final bool isMicActive;
  final bool isVideoActive;
  final bool isPendingConnection;

  @override
  Widget build(BuildContext context) {
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
                      ? Image.network(
                          'https://www.siegemedia.com/wp-content/uploads/2020/12/business-blogs-that-work-03-barkbox.webp',
                          fit: BoxFit.cover,
                        )
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
                  if (isPendingConnection)
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
            name,
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
