import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/login/login_controller.dart';
import 'package:pikpo_video_conference/theme/app_colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final LoginController _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onClearUsername() {
    _controller.usernameController.clear();
  }

  void _routeToCallScreen() {
    final usernameText = _controller.usernameController.text;
    if (usernameText.isNotEmpty) {
      Navigator.pushNamed(context, '/call',
          arguments: _controller.usernameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 108),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UsernameText(),
          UsernameTextField(
              controller: _controller.usernameController,
              onClearPressed: _onClearUsername),
          ButtonRow(on1To1Pressed: _routeToCallScreen),
        ],
      ),
    );
  }
}

//Button  Group Widget
class ButtonRow extends StatelessWidget {
  final VoidCallback on1To1Pressed;
  const ButtonRow({super.key, required this.on1To1Pressed});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Wrap(
        spacing: 20,
        runSpacing: 9,
        children: [
          ElevatedButton(
            onPressed: on1To1Pressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              fixedSize: const Size(150, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "1-1",
              style: TextStyle(
                  color: AppColors.textColor, fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              fixedSize: const Size(150, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Group",
              style: TextStyle(
                  color: AppColors.textColor, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

//Username Textfield Widget with controller and clear text handler
class UsernameTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClearPressed;

  const UsernameTextField({
    super.key,
    required this.controller,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key("usernameTextField"),
      controller: controller,
      style: const TextStyle(color: AppColors.textColor),
      decoration: InputDecoration(
        hoverColor: Colors.transparent,
        suffixIcon: ElevatedButton(
            key: const Key("clearUsernameButton"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                overlayColor: Colors.transparent,
                padding: EdgeInsets.all(0),
                shape: CircleBorder()),
            onPressed: onClearPressed,
            child: const Icon(
              Icons.cancel_rounded,
              color: AppColors.textColor,
            )),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        border: InputBorder.none,
        hintText: "Your Username",
        hintStyle: const TextStyle(color: AppColors.textVariant, fontSize: 16),
      ),
    );
  }
}

// "Usermame" Text
class UsernameText extends StatelessWidget {
  const UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Username',
      style: TextStyle(
          color: AppColors.textColor,
          fontSize: 28,
          fontWeight: FontWeight.bold),
    );
  }
}
