import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlarmView extends ConsumerWidget {
  const AlarmView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
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
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return const AlarmCard();
            },
            childCount: 5,
          ),
        )
      ],
    );
  }
}

class AlarmCard extends HookWidget {
  const AlarmCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var alarmActive = useState(false);

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
              children: [
                Text(
                  '20:00',
                  style: alarmActive.value
                      ? textTheme.displayMedium
                      : textTheme.displayMedium!.copyWith(
                          color: Colors.grey.shade700,
                        ),
                ),
                Text(
                  'Een keer',
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
