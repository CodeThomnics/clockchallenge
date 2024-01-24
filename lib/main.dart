import 'package:clockchallange/config/theme.dart';
import 'package:clockchallange/providers/alarm_list_provider.dart';
import 'package:clockchallange/providers/stopwatch_provider.dart';
import 'package:clockchallange/providers/stopwatch_running_provider.dart';
import 'package:clockchallange/providers/timezone_clocks_notifier_provider.dart';
import 'package:clockchallange/widgets/add_alarm_bottom_sheet.dart';
import 'package:clockchallange/widgets/add_timezone_view.dart';
import 'package:clockchallange/widgets/alarm_view.dart';
import 'package:clockchallange/widgets/stopwatch_view.dart';
import 'package:clockchallange/widgets/timer_view.dart';
import 'package:clockchallange/widgets/world_clock_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: ClockApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ClockScreen();
      },
    ),
    GoRoute(
      path: '/add',
      builder: (BuildContext context, GoRouterState state) {
        return const AddTimezoneView();
      },
    ),
  ],
);

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Clock App',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('nl', 'NL'),
      ],
      locale: const Locale('nl', 'NL'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: lightTheme,
      // ThemeData.light().copyWith(
      //   brightness: Brightness.light,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
      //   textTheme: GoogleFonts.oxygenTextTheme(),
      // ),
      darkTheme: darkTheme,
      // ThemeData.dark().copyWith(
      //   brightness: Brightness.dark,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
      //   textTheme: GoogleFonts.oxygenTextTheme(ThemeData.dark().textTheme),
      //   appBarTheme: ThemeData.dark().appBarTheme.copyWith(
      //         backgroundColor: Colors.black,
      //         titleTextStyle: const TextStyle(
      //           color: Colors.white,
      //         ),
      //         iconTheme:
      //             ThemeData.dark().iconTheme.copyWith(color: Colors.white),
      //       ),
      // ),
      themeMode: ThemeMode.dark,
      routerConfig: _router,
    );
  }
}

class ClockScreen extends HookConsumerWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentIndex = useState(0);
    var isRunning = ref.watch(stopwatchRunningProvider);
    var changeFloatingActionbutton =
        useCallback<Widget? Function(int)>((int index) {
      if (index == 0) {
        return FloatingActionButton(
          onPressed: () => context.go('/add'),
          child: const Icon(Icons.add),
        );
      }
      if (index == 1) {
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.grey.shade900,
                useRootNavigator: true,
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return AddAlarmBottomSheet();
                });
          },
          child: const Icon(Icons.add_alarm),
        );
      }
      if (index == 3) {
        return SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  ref.read(stopwatchRunningProvider.notifier).state =
                      !isRunning;
                  if (!isRunning) {
                    ref.read(stopwatchProvider).start();
                  } else {
                    ref.read(stopwatchProvider).stop();
                  }
                },
                child: isRunning
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
              const SizedBox(
                width: 10,
                height: 0,
              ),
              if (!isRunning) ...[
                FloatingActionButton(
                  onPressed: () {
                    ref.read(stopwatchRunningProvider.notifier).state = false;
                    ref.read(stopwatchProvider).reset();
                  },
                  child: const Icon(Icons.replay),
                ),
              ],
            ],
          ),
        );
      }
      return null;
    }, [isRunning]);

    var onTapPressed = useCallback<void Function(int)>(
      (int index) {
        currentIndex.value = index;
      },
      [],
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ref.read(alarmListProvider.notifier).setInitial();
        ref.read(timezoneClocksProvider.notifier).setInitial();
      });
      return () {};
    }, []);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex.value,
        children: const [
          WorldClockView(),
          AlarmView(),
          TimerView(),
          StopwatchView(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: changeFloatingActionbutton(currentIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex.value,
        onTap: onTapPressed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Wereldklok',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.hourglass_bottom),
            icon: Icon(Icons.hourglass_empty),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.timer),
            icon: Icon(Icons.timer_outlined),
            label: 'Stopwatch',
          ),
        ],
      ),
    );
  }
}
