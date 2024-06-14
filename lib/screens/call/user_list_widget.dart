import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class UserListWidget extends StatelessWidget {
  final Map<String, dynamic> stateList;
  const UserListWidget({super.key, required this.stateList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate size based on available space
            double textSize = constraints.maxHeight * 0.1; // 10% of height
            double imageSize = constraints.maxHeight * 0.40; // 60% of height

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserWidget(
                      name: "Arizli R",
                      isMicActive: stateList['isMicActive'],
                      textSize: textSize,
                      imageSize: imageSize),
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
                      name: "Senshi",
                      isMicActive: false,
                      textSize: textSize,
                      imageSize: imageSize)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.name,
    required this.isMicActive,
    required this.textSize,
    required this.imageSize,
  });

  final double textSize;
  final double imageSize;
  final String name;
  final bool isMicActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
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
                Image.network(
                  'https://www.siegemedia.com/wp-content/uploads/2020/12/business-blogs-that-work-03-barkbox.webp',
                  fit: BoxFit.cover,
                ),
                !isMicActive
                    ? Container(
                        color: Colors.black.withOpacity(
                            0.5), // Mengatur warna dan tingkat opacity
                        width: double
                            .infinity, // Sesuaikan ukuran sesuai kebutuhan
                        height: double.infinity,
                        child: const Icon(
                          Icons.mic_off_outlined,
                          color: AppColors.textColor,
                        ), // Sesuaikan ukuran sesuai kebutuhan
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
