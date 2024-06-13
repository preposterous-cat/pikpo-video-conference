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
      padding: const EdgeInsets.symmetric(vertical: 66, horizontal: 27),
      child: Column(
        children: [
          Column(
            children: [
              Row(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        fixedSize: const Size(24, 24),
                        backgroundColor: Colors.transparent),
                    child: const Icon(
                      Icons.output,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              Padding(
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
                            backgroundColor:
                                AppColors.backgroundColor.withOpacity(0.1),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryVariant,
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Your Name",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 9.36,
                            ),
                            SizedBox(
                              width: 59,
                              height: 84.51,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Image.network(
                                  'https://www.siegemedia.com/wp-content/uploads/2020/12/business-blogs-that-work-03-barkbox.webp',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          child: SvgPicture.asset(
                            'assets/images/vector.svg', // Path to your SVG
                            width: 11.33,
                            height: 11.33,
                            color: AppColors.highlightColor,
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              "Your Name",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 9.36,
                            ),
                            SizedBox(
                              width: 59,
                              height: 84.51,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryVariant,
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width,
                  height: 229,
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
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
