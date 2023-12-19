import 'dart:async';

import 'package:clockchallange/providers/stopwatch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StopwatchView extends HookConsumerWidget {
  const StopwatchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var stopwatch = ref.watch(stopwatchProvider);
    var time = useState(Duration.zero);
    useEffect(() {
      var timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
        time.value = stopwatch.elapsed;
      });
      return () {
        timer.cancel();
      };
    });
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            painter: ClockPainter(),
          ),
          Text(time.value.toString().split('.').first,
              style: Theme.of(context).textTheme.displayLarge),
        ],
      ),
    );
  }
}

/// custom Clock
class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(10, 10), 50, paint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ClockPainter oldDelegate) => false;
}
