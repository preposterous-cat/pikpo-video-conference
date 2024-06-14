import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class ShareScreenWidget extends StatelessWidget {
  const ShareScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
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
