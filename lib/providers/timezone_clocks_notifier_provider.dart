import 'package:clockchallange/models/timezone.dart';
import 'package:clockchallange/notifiers/timezone_clocks_notifier.dart';
import 'package:clockchallange/providers/timezone_file_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timezoneClocksProvider =
    StateNotifierProvider<TimezoneClocksNotifier, List<TimeZone>>((ref) {
  var jsonFileService = ref.watch(timezoneJsonFileServiceProvider);
  return TimezoneClocksNotifier(jsonFileService: jsonFileService);
});
