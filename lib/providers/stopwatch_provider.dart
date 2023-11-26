import 'package:hooks_riverpod/hooks_riverpod.dart';

final stopwatchProvider = Provider<Stopwatch>((_) {
  return Stopwatch();
});
