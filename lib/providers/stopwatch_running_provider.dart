import 'package:riverpod/riverpod.dart';

final stopwatchRunningProvider = StateProvider<bool>((_) {
  return false;
});
