import 'package:clockchallange/services/alarm_json_file_service.dart';
import 'package:riverpod/riverpod.dart';

final alarmJsonFileServiceProvider = Provider<AlarmJsonFileService>((_) {
  return AlarmJsonFileService();
});
