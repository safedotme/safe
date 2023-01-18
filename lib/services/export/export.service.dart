import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
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

    // ⬇️ CREATE DIRECTORY
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

    // ⬇️ DOWNLOAD WATERMARKED VIDEO
    final video = await _downloadVideo(i.path, directory);

    // ⬇️ PROCESS BATTERY DATA
    final battery = await _processBatteryLog(i.battery, directory);

    // ⬇️ PROCESS CONTACT DATA
    final contact = await _processContactLog(i.contactLog, directory);

    // ⬇️ PROCESS LOCATION DATA
    final location = await _processLocationLog(i.location, directory);

    // ⬇️ COMPRESS TO ZIP
    final nullable = [location, contact, battery, video];
    List<File> files = [];

    for (final contender in nullable) {
      if (contender != null) {
        files.add(contender);
      }
    }

    if (files.isEmpty) return null;

    try {
      final encoder = ZipFileEncoder()..create("${directory.path}/data.zip");

      for (final f in files) {
        await encoder.addFile(f);
      }
      encoder.close();
    } catch (e) {
      return null;
    }

    return File("${directory.path}/data.zip");
  }

  Future<File?> _processBatteryLog(List<Battery>? b, Directory dir) async {
    if (b == null || b.isEmpty) return null;

    List<List<dynamic>> rows = [];

    // ADD ROWS
    rows.add(["Date", "Time", "Battery Percentage"]);

    // POPULATE ROWS
    for (final bat in b) {
      List<dynamic> row = [];
      // DATE
      row.add(
        "${DateFormat.yMMMMd().format(bat.datetime)} (${bat.datetime.timeZoneName})",
      );

      // TIME
      row.add(
        "${DateFormat.jms().format(bat.datetime)} (${bat.datetime.timeZoneName})",
      );

      // PERCENTAGE
      row.add("${bat.percentage * 100}%");

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    File f = File("${dir.path}/battery_log.csv");

    return f.writeAsString(csv);
  }

  Future<File?> _processContactLog(
      List<NotifiedContact>? c, Directory dir) async {
    if (c == null || c.isEmpty) return null;

    List<List<dynamic>> rows = [];

    // ADD ROWS
    rows.add(["Date", "Time", "Contact Name", "Phone Number", "Message Type"]);

    // POPULATE ROWS
    for (final contact in c) {
      List<dynamic> row = [];
      // DATE
      row.add(
        "${DateFormat.yMMMMd().format(contact.datetime)} (${contact.datetime.timeZoneName})",
      );

      // TIME
      row.add(
        "${DateFormat.jms().format(contact.datetime)} (${contact.datetime.timeZoneName})",
      );

      // CONTACT NAME
      row.add(contact.name);

      // PHONE NUMBER
      row.add(contact.phone);

      // MESSAGE TYPE
      String type = contact.type.toString();
      row.add(
        type.substring(type.indexOf(".") + 1, type.length),
      );

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    File f = File("${dir.path}/contact_log.csv");

    return f.writeAsString(csv);
  }

  Future<File?> _processLocationLog(List<Location>? l, Directory dir) async {
    if (l == null || l.isEmpty) return null;

    List<List<dynamic>> rows = [];

    // ADD ROWS
    rows.add([
      "Date",
      "Time",
      "Latitude",
      "Longitude",
      "Device Accuracy (m)",
      "Speed (m/s)",
      "Altitude (m)",
      "Address",
    ]);

    // POPULATE ROWS
    for (final location in l) {
      List<dynamic> row = [];
      // DATE
      row.add(
        "${DateFormat.yMMMMd().format(location.datetime)} (${location.datetime.timeZoneName})",
      );

      // TIME
      row.add(
        "${DateFormat.jms().format(location.datetime)} (${location.datetime.timeZoneName})",
      );

      // LATITUDE
      row.add(location.lat);

      // LONGITUDE
      row.add(location.long);

      // DEVICE ACCURACY
      row.add(location.accuracy);

      // SPEED
      row.add(location.speed);

      // ALTITUDE
      row.add(location.alt);

      // ADDRESS
      row.add(location.address);

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    File f = File("${dir.path}/location_log.csv");

    return f.writeAsString(csv);
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
