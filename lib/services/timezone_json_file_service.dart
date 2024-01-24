import 'dart:convert';
import 'dart:io';

import 'package:clockchallange/models/timezone.dart';
import 'package:path_provider/path_provider.dart';

class TimezoneJsonFileService {
  File? file;

  TimezoneJsonFileService();

  Future<void> write(List<TimeZone> timezones) async {
    await ensureFileSet();
    file!.writeAsStringSync(jsonEncode(timezones));
  }

  Future<List<TimeZone>> read() async {
    await ensureFileSet();
    if (file!.existsSync()) {
      String json = file!.readAsStringSync();
      var parsed = jsonDecode(json) as List;
      return parsed.map((model) => TimeZone.fromJson(model)).toList();
    }
    return [];
  }

  Future<void> ensureFileSet() async {
    file ??= await getStorageFile();
  }

  Future<File> getStorageFile() async {
    var path = await getApplicationFilePath();

    return File('$path/timezones.json');
  }

  Future<String> getApplicationFilePath() async {
    var dir = await getApplicationSupportDirectory();
    print(dir.path);
    return dir.path;
  }
}
