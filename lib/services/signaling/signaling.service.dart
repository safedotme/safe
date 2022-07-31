import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:safe/core.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class SignalingService {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;
  Core? core;

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

  void init(Core cre) => core = cre;

  /// Used by genesis client to create a session (call)
  Future<void> createSession(RTCVideoRenderer remoteRenderer) async {
    assert(core != null, "Core has not been initialized");

    peerConnection = await createPeerConnection(config);

    // Sets the state listeners for later use
    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    // Fetches local ICE candidates and uploads them
    peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      var incident = core!.state.capture.incident!;

      core!.services.server.incidents.upsert(
        incident.copyWith(
          rtcCandidates: incident.rtcCandidates == null
              ? [candidate.toMap()]
              : [
                  ...incident.rtcCandidates!,
                  candidate.toMap(),
                ],
        ),
      );
    };

    // Creates a session
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);

    // Uploads offer
    var incident = core!.state.capture.incident!;
    await core!.services.server.incidents.upsert(incident.copyWith(
      rtcOffer: offer.toMap(),
    ));

    // Adds track (audio & video) to remote stream
    peerConnection?.onTrack = (RTCTrackEvent event) {
      event.streams[0].getTracks().forEach((track) {
        remoteStream?.addTrack(track);
      });
    };

    // Listen for remote session descriptions (ADD)
    var stream = core!.services.server.incidents.readFromId(id: incident.id);

    stream.listen((event) async {
      if (peerConnection?.getRemoteDescription() != null &&
          event.rtcOffer?["answer"] != null) {
        // Create session description
        var answer = RTCSessionDescription(
          event.rtcOffer?["answer"]["sdp"],
          event.rtcOffer?["answer"]["type"],
        );

        await peerConnection?.setRemoteDescription(answer);
      }

      // Check if any candidates were added
      if (event.rtcCandidates != core!.state.signaling.candidates) {
        peerConnection!.addCandidate(
          RTCIceCandidate(
            event.rtcCandidates!.last["candidate"],
            event.rtcCandidates!.last["sdpMid"],
            event.rtcCandidates!.last["sdpMLineIndex"],
          ),
        );

        core!.state.signaling.setCandidates(event.rtcCandidates!);
      }
    });
  }

  /// Gets media information for all clients
  Future<void> openLocalMedia(
    RTCVideoRenderer localVideo,
    RTCVideoRenderer remoteVideo,
  ) async {
    var stream = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': false});

    localVideo.srcObject = stream;
    localStream = stream;

    remoteVideo.srcObject = await createLocalMediaStream('key');
  }

  /// Stops all tracks and streams
  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    List<MediaStreamTrack> tracks = localVideo.srcObject!.getTracks();
    tracks.forEach((track) {
      track.stop();
    });

    if (remoteStream != null) {
      remoteStream!.getTracks().forEach((track) => track.stop());
    }

    if (peerConnection != null) peerConnection!.close();

    localStream!.dispose();
    remoteStream?.dispose();
  }

  /// Sets listeners for each event
  void registerPeerConnectionListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: $state');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      print("Add remote stream");
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }
}