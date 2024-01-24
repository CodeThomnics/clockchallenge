import 'package:clockchallange/services/timezone_json_file_service.dart';
import 'package:riverpod/riverpod.dart';

final timezoneJsonFileServiceProvider = Provider<TimezoneJsonFileService>((_) {
  return TimezoneJsonFileService();
});
