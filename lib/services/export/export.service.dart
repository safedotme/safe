import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as platform;
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/services/storage/storage.service.dart';

class ExportService {
  Future<File?> export(Incident? i) async {
    if (i == null) return null;
    Directory? directory;

    try {
      final dir = await platform.getApplicationDocumentsDirectory();
      directory = Directory("${dir.path}/${i.path}/");

      bool exists = await directory.exists();

      if (!exists) {
        await directory.create();
      }
    } catch (_) {
      return null;
    }

    var test = await _downloadVideo(i.path, directory);

    if (test == null) return null;
  }

  Future<File?> _processBatteryLog(List<Battery>? b) async {
    return null;
  }

  Future<File?> _processContactLog(List<NotifiedContact>? b) async {
    return null;
  }

  Future<File?> _processLocationLog(List<Location>? b) async {
    return null;
  }

  Future<File?> _downloadVideo(String? path, Directory dir) async {
    if (path == null) return null;

    final client = StorageService()..init();

    final url = await client.getDownloadUrl("$path/raw/watermarked.mp4");

    if (url["error"] != null) return null;
    File? file;

    try {
      file = File("${dir.path}/recording.mp4");

      final res = await Dio().get(
        url["url"],
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raw = file.openSync(mode: FileMode.write);
      raw.writeFromSync(res.data);
      await raw.close();
    } catch (e) {
      print(e);
    }

    return file;
  }
}
