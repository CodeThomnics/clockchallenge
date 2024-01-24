import 'package:clockchallange/models/alarm_model.dart';
import 'package:clockchallange/notifiers/alarm_list_notifier.dart';
import 'package:clockchallange/providers/alarm_json_file_service_provider.dart';
import 'package:riverpod/riverpod.dart';

final alarmListProvider =
    StateNotifierProvider<AlarmListNotifier, List<AlarmModel>>((ref) {
  var jsonFileService = ref.watch(alarmJsonFileServiceProvider);
  return AlarmListNotifier(jsonFileService: jsonFileService);
});
