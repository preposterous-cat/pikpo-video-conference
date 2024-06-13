import 'package:flutter/material.dart';
import 'package:pikpo_video_conference/screens/call/call_screen.dart';
import 'package:pikpo_video_conference/screens/login/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pikpo Video Conference',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/call') {
          final username = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => CallScreen(username: username),
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
