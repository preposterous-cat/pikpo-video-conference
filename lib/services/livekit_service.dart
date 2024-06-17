import 'package:flutter/foundation.dart';
import 'package:livekit_client/livekit_client.dart';

class LiveKitService {
  final String url;
  final String token;
  late Room room;

  LiveKitService({required this.url, required this.token}) {
    room = Room();
  }

  Future<void> connectToRoom() async {
    var roomOptions = const RoomOptions(adaptiveStream: true, dynacast: true);

    await room.connect(url, token, roomOptions: roomOptions);
    try {
      // video will fail when running in ios simulator
      await room.localParticipant?.setCameraEnabled(true);
    } catch (error) {
      if (kDebugMode) {
        print('Could not publish video, error: $error');
      }
    }

    await room.localParticipant?.setMicrophoneEnabled(true);
  }

  Future<void> disconnectRoom() async {
    await room.disconnect();
  }
}
