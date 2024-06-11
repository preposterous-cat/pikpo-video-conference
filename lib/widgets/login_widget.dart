import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username',
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          TextField(
            style: TextStyle(color: AppColors.textColor),
            decoration: InputDecoration(
              suffixIcon: ElevatedButton(
                  onPressed: null,
                  child: Icon(
                    Icons.cancel_rounded,
                    color: AppColors.textColor,
                  )),
              suffixIconColor: AppColors.textColor,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              border: InputBorder.none,
              hintText: "Your Username",
              hintStyle: TextStyle(color: AppColors.textVariant, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
