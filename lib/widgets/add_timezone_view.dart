import 'package:clockchallange/providers/timeszones_provider.dart';
import 'package:clockchallange/providers/timezone_clocks_notifier_provider.dart';
import 'package:clockchallange/services/worldtime_api_service.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class AddTimezoneView extends HookConsumerWidget {
  const AddTimezoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchController = useSearchController();
    var timezones = ref.watch(timezonesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          'Add a clock',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        children: [
          Container(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchAnchor.bar(
              searchController: searchController,
              suggestionsBuilder: (context, controller) {
                var filteredList = <String>[];
                var filteredTimezones = extractAllSorted(
                  query: controller.value.text,
                  choices: timezones,
                  cutoff: 10,
                );
                if (controller.value.text.isEmpty) {
                  filteredList = timezones;
                } else {
                  filteredList = filteredTimezones
                      .map(
                        (result) => result.choice,
                      )
                      .toList();
                }
                return filteredList.map((timezone) => ListTile(
                      onTap: () {
                        controller.closeView(timezone);
                      },
                      title: Text(timezone),
                    ));
              },
            ),
          ),
          Container(height: 24),
          FilledButton(
            onPressed: () async {
              var choice = ref
                  .read(timezonesProvider)
                  .firstWhere((timezone) => searchController.text == timezone);
              var newTimezone = await WorldTimeAPIService().getTimezone(choice);
              ref.read(timezoneClocksProvider).add(newTimezone);
              if (context.mounted) {
                context.go("/");
              }
            },
            child: const Text('Add timezone'),
          )
        ],
      ),
    );
  }
}
