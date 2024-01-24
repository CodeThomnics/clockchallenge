import 'package:clockchallange/models/timezone.dart';
import 'package:clockchallange/services/timezone_json_file_service.dart';
import 'package:riverpod/riverpod.dart';

class TimezoneClocksNotifier extends StateNotifier<List<TimeZone>> {
  TimezoneClocksNotifier({required this.jsonFileService}) : super([]);

  final TimezoneJsonFileService jsonFileService;

  Future<void> setInitial() async {
    var savedTimezones = await jsonFileService.read();
    state = [
      ...savedTimezones,
    ];
  }

  Future<void> add(TimeZone timeZone) async {
    state = [
      ...state,
      timeZone,
    ];
    await jsonFileService.write(state);
  }

  Future<void> remove(TimeZone timeZone) async {
    var newState = state;
    newState.remove(timeZone);
    state = newState;
    await jsonFileService.write(state);
  }
}
