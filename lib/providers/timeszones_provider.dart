import 'package:clockchallange/notifiers/timezones_notifier.dart';
import 'package:riverpod/riverpod.dart';

final timezonesProvider =
    StateNotifierProvider<TimezonesNotifier, List<String>>((ref) {
  return TimezonesNotifier();
});
