import 'package:clockchallange/models/timezone.dart';
import 'package:clockchallange/services/worldtime_api_service.dart';
import 'package:riverpod/riverpod.dart';

final currentTimezoneProvider = FutureProvider<TimeZone>((ref) async {
  return await WorldTimeAPIService().getCurrentTimezone();
});
