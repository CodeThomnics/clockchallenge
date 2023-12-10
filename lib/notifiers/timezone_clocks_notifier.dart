import 'package:clockchallange/models/timezone.dart';
import 'package:riverpod/riverpod.dart';

class TimezoneClocksNotifier extends StateNotifier<List<TimeZone>> {
  TimezoneClocksNotifier() : super([]);

  add(TimeZone timeZone) {
    state = [
      ...state,
      timeZone,
    ];
  }

  remove(TimeZone timeZone) {
    var newState = state;
    newState.remove(timeZone);
    state = newState;
  }
}
