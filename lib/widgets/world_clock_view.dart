import 'dart:async';

import 'package:clockchallange/providers/timezone_clocks_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:clockchallange/models/timezone.dart';
import 'package:clockchallange/providers/current_time_provider.dart';
import 'package:clockchallange/providers/current_timezone_provider.dart';
import 'package:clockchallange/utils/time_format.dart';

class WorldClockView extends HookConsumerWidget {
  const WorldClockView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    var locale = Localizations.localeOf(context);
    var currentTimezone = useState(TimeZone());
    var time = ref.watch(currentTimeProvider);
    var timezoneClocks = ref.watch(timezoneClocksProvider);
    ref.read(currentTimezoneProvider).whenData(
          (timeZone) => currentTimezone.value = timeZone,
        );
    useEffect(() {
      // WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   await WorldTimeAPIService().getCurrentTimezone();
      // });
      // print(Platform.localeName);
      var timer = Timer.periodic(const Duration(seconds: 1), (_) {
        var currentTimeNotifier = ref.read(currentTimeProvider.notifier);
        currentTimeNotifier.state = currentTimeNotifier.state.add(
          const Duration(seconds: 1),
        );
      });
      return () {
        timer.cancel();
      };
    }, []);

    useOnAppLifecycleStateChange((_, current) {
      if (current == AppLifecycleState.resumed) {
        ref.invalidate(currentTimeProvider);
      }
    });

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          collapsedHeight: 120,
          expandedHeight: 240,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hmsFormat(locale).format(time),
                    style: theme.textTheme.displaySmall,
                  ),
                  Text(
                    "${currentTimezone.value.timezone} | ${dayMonthDateFormat().format(DateTime.now())}",
                    style: theme.textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 124.0,
          delegate: SliverChildListDelegate([
            for (var timezoneClock in timezoneClocks) ...[
              CityTimeZone(
                timezone: timezoneClock,
              )
            ],
          ]),
        ),
      ],
    );
  }
}

class CityTimeZone extends HookConsumerWidget {
  const CityTimeZone({
    super.key,
    required this.timezone,
  });

  final TimeZone timezone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var locale = Localizations.localeOf(context);
    var fetchedTimezone = useState(TimeZone());
    var currentTime = ref.watch(currentTimeProvider);
    var timezoneTime = useState(currentTime);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // make the offset of timezone in difference of the current timezone
        // with adding the daylight savings
        var time = currentTime.toUtc();
        var offset = timezone.rawOffset + timezone.dstOffset;
        if (timezone.rawOffset > 0) {
          timezoneTime.value = time.add(Duration(seconds: offset));
        } else if (timezone.rawOffset < 0) {
          timezoneTime.value = time.subtract(Duration(seconds: (offset * -1)));
        }
        fetchedTimezone.value = timezone;
      });
      return () {};
    }, [
      currentTime.minute,
    ]);
    return Container(
      height: 400,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timezone.timezone,
                  style: textTheme.headlineMedium,
                ),
                Text(
                  "${fetchedTimezone.value.utcOffset}",
                  style: textTheme.bodyLarge,
                )
              ],
            ),
            Text(
              hmFormat(locale).format(timezoneTime.value),
              style: textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
