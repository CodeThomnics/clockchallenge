import 'package:clockchallange/models/alarm_model.dart';
import 'package:clockchallange/providers/alarm_list_provider.dart';
import 'package:clockchallange/utils/time_format.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlarmView extends HookConsumerWidget {
  const AlarmView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    var alarmList = ref.watch(alarmListProvider);
    var sortedAlarmList = useState([]);

    useEffect(() {
      sortedAlarmList.value = alarmList
          .sortedBy((element) => element.hour)
          .thenBy((element) => element.minute);
      return () {};
    }, [alarmList]);
    if (alarmList.isNotEmpty) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            title: Text(
              'Alarmen',
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(sortedAlarmList.value
                  .map((alarm) => AlarmCard(alarm))
                  .toList()))
        ],
      );
    }
    return Container();
  }
}

class AlarmCard extends HookWidget {
  const AlarmCard(
    this.alarm, {
    super.key,
  });

  final AlarmModel alarm;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var alarmActive = useState(alarm.active);

    return Container(
      height: 140,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${alarm.hour.timeClockFormat()}:${alarm.minute.timeClockFormat()}',
                  style: alarmActive.value
                      ? textTheme.displayMedium
                      : textTheme.displayMedium!.copyWith(
                          color: Colors.grey.shade700,
                        ),
                ),
                Text(
                  alarm.name.isNotEmpty
                      ? 'Een keer | ${alarm.name}'
                      : 'Een keer',
                  style: alarmActive.value
                      ? textTheme.titleLarge
                      : textTheme.titleLarge!.copyWith(
                          color: Colors.grey.shade700,
                        ),
                )
              ],
            ),
            Switch.adaptive(
              value: alarmActive.value,
              onChanged: (newValue) {
                alarmActive.value = newValue;
              },
            ),
          ],
        ),
      ),
    );
  }
}
