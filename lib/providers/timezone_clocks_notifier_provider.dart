import 'package:clockchallange/models/timezone.dart';
import 'package:clockchallange/notifiers/timezone_clocks_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timezoneClocksProvider =
    StateNotifierProvider<TimezoneClocksNotifier, List<TimeZone>>((ref) {
  return TimezoneClocksNotifier();
});
