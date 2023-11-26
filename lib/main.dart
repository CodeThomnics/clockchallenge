
import 'package:clockchallange/providers/stopwatch_provider.dart';
import 'package:clockchallange/providers/stopwatch_running_provider.dart';
import 'package:clockchallange/widgets/alarm_view.dart';
import 'package:clockchallange/widgets/stopwatch_view.dart';
import 'package:clockchallange/widgets/timer_view.dart';
import 'package:clockchallange/widgets/world_clock_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: ClockApp(),
    ),
  );
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
        textTheme: GoogleFonts.oxygenTextTheme(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
        textTheme: GoogleFonts.oxygenTextTheme(ThemeData.dark().textTheme),
        appBarTheme: AppBarTheme(
            backgroundColor: ThemeData.dark().colorScheme.background),
      ),
      themeMode: ThemeMode.dark,
      home: const ClockScreen(),
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
          onPressed: () {},
          child: const Icon(Icons.add),
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
