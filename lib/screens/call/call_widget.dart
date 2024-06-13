import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class CallWidget extends StatefulWidget {
  final String username;
  const CallWidget({super.key, required this.username});

  @override
  State<CallWidget> createState() => _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavbarWidget(widget: widget),
          Expanded(
            flex: 5,
            child: ShareScreenWidget(),
          ),
          Expanded(
            flex: 3,
            child: UserListWidget(),
          ),
          Expanded(
            flex: 4,
            child: TranscriptWidget(),
          ),
          const CallControlWidget()
        ],
      ),
    );
  }
}

class CallControlWidget extends StatelessWidget {
  const CallControlWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Wrap(
        spacing: 20,
        runSpacing: 8,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size(50, 50),
              shape: const CircleBorder(),
              backgroundColor: AppColors.primaryVariant,
            ),
            onPressed: () {},
            child: const Icon(
              Icons.mic_none_rounded,
              color: AppColors.textColor,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size(50, 50),
              shape: const CircleBorder(),
              backgroundColor: AppColors.primaryVariant,
            ),
            onPressed: () {},
            child: const Icon(
              Icons.videocam_outlined,
              color: AppColors.textColor,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size(50, 50),
              shape: const CircleBorder(),
              backgroundColor: AppColors.primaryVariant,
            ),
            onPressed: () {},
            child: const Text(
              "T",
              style: TextStyle(
                  color: AppColors.textColor, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size(50, 50),
              shape: const CircleBorder(),
              backgroundColor: AppColors.primaryVariant,
            ),
            onPressed: () {},
            child: SvgPicture.asset(
              'assets/images/sketch.svg', // Path to your SVG
              width: 18,
              height: 14.19,
              color: AppColors.textColor,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size(50, 50),
              shape: const CircleBorder(),
              backgroundColor: AppColors.primaryVariant,
            ),
            onPressed: () {},
            child: const Icon(
              Icons.present_to_all_rounded,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class TranscriptWidget extends StatelessWidget {
  const TranscriptWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryVariant,
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transcript",
                  style: TextStyle(color: AppColors.textColor),
                ),
                Icon(
                  Icons.open_in_full_rounded,
                  color: AppColors.textColor,
                  size: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserListWidget extends StatelessWidget {
  const UserListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
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
            double imageSize = constraints.maxHeight * 0.43; // 60% of height

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "Your Name",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: textSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: textSize *
                            0.9, // Adjust space between text and image
                      ),
                      SizedBox(
                        width: imageSize,
                        height: imageSize * 1.7, // Maintain aspect ratio
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              imageSize * 0.5), // Make it circular
                          child: Image.network(
                            'https://www.siegemedia.com/wp-content/uploads/2020/12/business-blogs-that-work-03-barkbox.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
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
                  Column(
                    children: [
                      Text(
                        "Your Name",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: textSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: textSize * 0.9,
                      ),
                      SizedBox(
                        width: imageSize,
                        height: imageSize * 1.7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(imageSize * 0.5),
                          child: Image.network(
                            'https://www.siegemedia.com/wp-content/uploads/2020/12/business-blogs-that-work-03-barkbox.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShareScreenWidget extends StatelessWidget {
  const ShareScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 224,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                'https://www.siegemedia.com/wp-content/uploads/2020/12/business-blogs-that-work-03-barkbox.webp',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor.withOpacity(0.1),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () {
                  // Aksi yang ingin dilakukan saat tombol ditekan
                },
                child: const Icon(
                  size: 20,
                  Icons.open_in_full_outlined,
                  color: Colors.white, // Warna ikon
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
