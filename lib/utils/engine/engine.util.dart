// ignore_for_file: unused_field
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/shard.model.dart';
import 'package:safe/services/storage/shard_storage.service.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class IngestionEngine {
  final IsolateManager _manager = IsolateManager();
  late CameraController _controller;
  late Incident _incident;
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
  void initialize({
    required CameraController c,
    required Core cre,
    required Incident incident,
  }) async {
    _controller = c;
    _core = cre;

    // Start recording

    await _controller.startVideoRecording();

    // Start scheduler
    _ticker = Timer.periodic(clipBound, _tick);

    setIncident(incident, true);
  }

  // Called when user wishes to stop recording
  void stop() {
    _ticker.cancel();
  }

  Future<void> setIncident(Incident i, bool upload) async {
    _incident = i;
    _core.state.capture.setIncident(i);

    if (upload) {
      _core.services.server.incidents.upsert(i);
    }
  }

  void _generateThumbnail(XFile file) {
    // Add thumbnail functionality
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

    List<Shard>? shards = _incident.shards;

    setIncident(
      _incident.copyWith(shards: shards == null ? [shard] : [...shards, shard]),
      true,
    );

    // Sends data to be processed by the isolate manager
    _manager.request(
      {"file": file, "shard": shard, "taken": false},
      _core,
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

typedef HandleJob = Map<String, dynamic>? Function(Map<String, dynamic>? id);

class ThreadWorker {
  final Core core;
  final int id;
  ThreadWorker(this.id, this.core);

  // STATE
  bool working = false;

  // onFinish returns next job (or null if none) and takes the object to remove job from stack
  void processJob(HandleJob onFinish) async {
    working = true;
    var job = onFinish(null);

    while (job != null) {
      await Future.delayed(Duration(seconds: 3));
      XFile file = job["file"];
      Shard shard = job["shard"];

      // Handles compression and uploading
      await intake(file.path, shard, shard.position == 0);

      job = onFinish(job);
    }

    working = false;
  }

  Future<MediaInfo?> compress(String path) async {
    var media = await VideoCompress.compressVideo(
      path,
      includeAudio: true,
      deleteOrigin: false,
    );

    return media;
  }

  Future<File> genThumbnail(String path) async {
    var thumbnail = await VideoCompress.getFileThumbnail(path);

    return thumbnail;
  }

  Future<Shard?> upload(Shard sh, String path) {
    var service = ShardStorageService();

    // Takes incidents and extracts bucket ids
    List<String?> ids = (core.state.capture.incident!.shards ?? [])
        .map((e) => e.bucketId)
        .toList()
      ..removeWhere((e) => e == null);

    // Confirms datatypes
    var nonNullIds = List<String>.from(ids);

    // Sets bucket based on previous shards
    service.setDistributedBucket(nonNullIds);

    return service.uploadShardContent(sh, path);
  }

  Future<void> intake(String path, Shard shard, bool shouldGenThumbnail) async {
    var media = await compress(path);
    // Upload

    if (shouldGenThumbnail) {
      var image = await genThumbnail(path);
      print(image);
      // Upload
    }

    // Send to firestore
    // SET INCIDENT HERE
    // core.services.server.incidents.upsert(
    //   // UPDATE WITH DATA
    //   core.state.capture.incident!.copyWith(),
    // );
  }
}

class IsolateManager {
  // LATER: Update thread availability for horizontal scaling
  static const int threadAvailability = 2;
  List<Map<String, dynamic>> backlog = [];
  List<ThreadWorker> workers = [];

  /// Used to request a job esternally
  void request(Map<String, dynamic> job, Core core) {
    backlog.add(job);

    if (workers.isEmpty) {
      _populate(core);
    }

    review();
    return;
  }

  /// Populates worker pool based on the thread availability
  void _populate(Core core) {
    for (int i = 0; i < threadAvailability; i++) {
      var worker = ThreadWorker(i, core);

      workers.add(worker);
    }
  }

  // Checks if workers are available. If they are, it puts them to work
  void review() async {
    for (ThreadWorker worker in workers) {
      if (!worker.working) {
        _clockIn(worker.id);
      }
    }
  }

  /// Distributes jobs when workers ask for them or assigns jobs when they're not working
  void _clockIn(int workerId) {
    workers[workerId].processJob((job) {
      if (job != null) {
        backlog.remove(job);
      }

      var available = backlog;

      if (available.isEmpty) {
        return null;
      }

      available.removeWhere((element) => element["taken"]);

      if (available.isEmpty) {
        return null;
      }

      var newJob = available[0];

      // change new job to taken
      backlog[backlog.indexOf(newJob)]["taken"] = true;

      return newJob;
    });
  }
}
