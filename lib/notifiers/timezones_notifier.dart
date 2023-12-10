import 'package:clockchallange/services/worldtime_api_service.dart';
import 'package:riverpod/riverpod.dart';

class TimezonesNotifier extends StateNotifier<List<String>> {
  TimezonesNotifier() : super([]) {
    fetch();
  }

  fetch() async {
    state = await WorldTimeAPIService().getAllTimezones();
  }
}
