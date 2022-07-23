// ignore_for_file: unused_field
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/shard.model.dart';
import 'package:uuid/uuid.dart';

class IngestionEngine {
  final IsolateManager _manager = IsolateManager();
  late CameraController _controller;
  late Core _core;
  late Timer _ticker;
  int i = 0;

  // Duration of each clip
  static const clipBound = Duration(seconds: 15);

  /// Called only when a user action clips as a byproductz
  void clip(CameraController c, Core core) {
    // Stop the recording

    _controller = c;
    // Reset the scheduler and route the clip
  }

  /// Called when a stream of clips begins (AFTER controller has been initialzied)
  void initialize(CameraController c, Core cre) async {
    _controller = c;
    _core = cre;

    // Start recording
    await _controller.startVideoRecording();

    // Start scheduler
    _ticker = Timer.periodic(Duration(seconds: 5), _tick);
  }

  // Called when user wishes to stop recording
  void stop() {
    // dispose controller
    // stop ticker
  }

  /// Uploads primitive data and sends rest to be handled by the manager
  void _route(XFile file, int position, DateTime time) {
    // Create the shard primitives
    var shard = Shard(
      shardId: Uuid().v1(),
      position: position,
      localPath: file.path,
      datetime: time,
    );
  }

  void _tick(Timer t) async {
    var time = DateTime.now();
    var file = await _controller.stopVideoRecording();
    _controller.startVideoRecording();

    // Ticks start at 1. Therefore, they are lowered by 1 to start at 0
    _route(file, t.tick - 1, time);
  }
}

class ThreadWorker {}

class IsolateManager {}
