import 'package:clockchallange/models/alarm_model.dart';
import 'package:clockchallange/providers/alarm_list_provider.dart';
import 'package:clockchallange/utils/time_format.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

enum AlarmFrequency { once, custom }

class AddAlarmBottomSheet extends HookConsumerWidget {
  const AddAlarmBottomSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    var alarmListServiceNotifier = ref.read(alarmListProvider.notifier);
    var currentTime = useState<DateTime>(DateTime.now());
    var newAlarm = useState(AlarmModel(id: const Uuid().v1()));
    var nameController = useTextEditingController();
    var alarmFrequencySelected = useState(AlarmFrequency.once);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [
            Text(
              hmFormat().format(currentTime.value),
              style: theme.textTheme.displayMedium!.copyWith(
                color: Colors.white,
              ),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () async {
                var chosenTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentTime.value),
                    ) ??
                    TimeOfDay.now();
                currentTime.value = DateTime.now()
                    .copyWith(hour: chosenTime.hour, minute: chosenTime.minute);
              },
              child: const Text('Kies een tijd'),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80,
              ),
              child: TextField(
                decoration: const InputDecoration(hintText: 'Naam'),
                controller: nameController,
              ),
            ),
            const Gap(20),
            SegmentedButton(
              segments: const [
                ButtonSegment(
                  value: AlarmFrequency.once,
                  label: Text('Een keer'),
                ),
                ButtonSegment(
                  value: AlarmFrequency.custom,
                  label: Text('Aangepast'),
                ),
              ],
              selected: {alarmFrequencySelected.value},
              onSelectionChanged: (newValue) {
                alarmFrequencySelected.value = newValue.first;
              },
            ),
            if (alarmFrequencySelected.value == AlarmFrequency.custom) ...[
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WeekdayToggle(
                    text: 'Ma',
                    current: newAlarm.value.monday,
                    onToggle: (monday) => newAlarm.value =
                        newAlarm.value.copyWith(monday: monday),
                  ),
                  WeekdayToggle(
                    text: 'Di',
                    current: newAlarm.value.tuesday,
                    onToggle: (tuesday) => newAlarm.value =
                        newAlarm.value.copyWith(tuesday: tuesday),
                  ),
                  WeekdayToggle(
                    text: 'Wo',
                    current: newAlarm.value.wednesday,
                    onToggle: (wednesday) => newAlarm.value =
                        newAlarm.value.copyWith(wednesday: wednesday),
                  ),
                  WeekdayToggle(
                    text: 'Do',
                    current: newAlarm.value.thursday,
                    onToggle: (thursday) => newAlarm.value =
                        newAlarm.value.copyWith(thursday: thursday),
                  ),
                  WeekdayToggle(
                    text: 'Vr',
                    current: newAlarm.value.friday,
                    onToggle: (friday) => newAlarm.value =
                        newAlarm.value.copyWith(friday: friday),
                  ),
                  WeekdayToggle(
                    text: 'Za',
                    current: newAlarm.value.saturday,
                    onToggle: (saturday) => newAlarm.value =
                        newAlarm.value.copyWith(saturday: saturday),
                  ),
                  WeekdayToggle(
                    text: 'Zo',
                    current: newAlarm.value.sunday,
                    onToggle: (sunday) => newAlarm.value =
                        newAlarm.value.copyWith(sunday: sunday),
                  ),
                ],
              ),
            ],
            const Spacer(),
            FilledButton(
              onPressed: () async {
                newAlarm.value = newAlarm.value.copyWith(
                  name: nameController.text,
                  hour: currentTime.value.hour,
                  minute: currentTime.value.minute,
                );
                alarmListServiceNotifier.add(newAlarm.value);
                if (context.mounted) {
                  context.pop();
                }
              },
              child: const Text('Opslaan'),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class WeekdayToggle extends StatelessWidget {
  const WeekdayToggle(
      {super.key,
      required this.text,
      required this.onToggle,
      this.current = false});

  final String text;
  final Function(bool) onToggle;
  final bool current;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: () {
        onToggle(!current);
      },
      child: SizedBox.fromSize(
        size: const Size.fromRadius(24),
        child: Container(
          decoration: BoxDecoration(
            color:
                current ? colorScheme.primaryContainer : colorScheme.background,
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
