import 'package:riverpod/riverpod.dart';

final currentTimeProvider = StateProvider<DateTime>((_) {
  return DateTime.now();
});
