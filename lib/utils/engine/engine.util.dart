// ignore_for_file: unused_field
import 'package:camera/camera.dart';
import 'package:safe/core.dart';

class IngestionEngine {
  final ClipScheduler _scheduler = ClipScheduler();
  final IsolateManager _manager = IsolateManager();
  late CameraController _controller;

  /// Called only when a user action clips as a byproduct
  void clip(CameraController c, Core core) {
    // Stop the recording

    _controller = c;
    // Reset the scheduler and route the clip
  }

  /// Called when a stream of clips begins
  void initialize(CameraController c) {
    _controller = c;
    // Start scheduler
  }

  /// Uploads primitive data and sends rest to be handled by the manager
  void _route() {}
}

class ClipScheduler {}

class ThreadWorker {}

class IsolateManager {}
