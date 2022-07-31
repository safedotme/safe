import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class SignalingService {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;

  // Configuration for testing (will change later)
  static const Map<String, dynamic> config = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };

  /// Used by genesis client to create a session (call)
  Future<String> createSession(RTCVideoRenderer remoteRenderer) async {}

  /// Used by external clients to join a session
  Future<void> joinSession() async {}

  /// Gets media information for all clients
  Future<void> openLocalMedia() async {}
}
