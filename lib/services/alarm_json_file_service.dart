import 'dart:convert';
import 'dart:io';

import 'package:clockchallange/models/alarm_model.dart';
import 'package:path_provider/path_provider.dart';

class AlarmJsonFileService {
  File? file;

  AlarmJsonFileService();

  Future<void> write(List<AlarmModel> alarms) async {
    await ensureFileSet();
    file!.writeAsStringSync(jsonEncode(alarms));
  }

  Future<List<AlarmModel>> read() async {
    await ensureFileSet();
    if (file!.existsSync()) {
      String json = file!.readAsStringSync();
      var parsed = jsonDecode(json) as List;
      return parsed.map((model) => AlarmModel.fromJson(model)).toList();
    }
    return [];
  }

  Future<void> ensureFileSet() async {
    file ??= await getStorageFile();
  }

  Future<File> getStorageFile() async {
    var path = await getApplicationFilePath();

    return File('$path/alarms.json');
  }

  Future<String> getApplicationFilePath() async {
    var dir = await getApplicationSupportDirectory();
    print(dir.path);
    return dir.path;
  }
}
