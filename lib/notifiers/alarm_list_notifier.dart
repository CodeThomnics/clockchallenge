import 'package:clockchallange/models/alarm_model.dart';
import 'package:clockchallange/services/alarm_json_file_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmListNotifier extends StateNotifier<List<AlarmModel>> {
  AlarmListNotifier({required this.jsonFileService}) : super([]);

  final AlarmJsonFileService jsonFileService;

  Future<void> setInitial() async {
    var savedAlarms = await jsonFileService.read();
    state = [
      ...savedAlarms,
    ];
  }

  Future<void> add(AlarmModel alarm) async {
    state = [
      ...state,
      alarm,
    ];
    await jsonFileService.write(state);
  }

  Future<void> remove(AlarmModel alarm) async {
    var newState = state;
    newState.remove(alarm);
    state = newState;
    await jsonFileService.write(state);
  }
}
