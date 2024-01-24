import 'package:intl/intl.dart';

DateFormat hmFormat([dynamic locale]) {
  if (locale != null) {
    return DateFormat.Hm(locale.toString());
  } else {
    return DateFormat.Hm();
  }
}

DateFormat hmsFormat([dynamic locale]) {
  if (locale != null) {
    return DateFormat.Hms(locale.toString());
  } else {
    return DateFormat.Hms();
  }
}

DateFormat dayMonthDateFormat([dynamic locale]) {
  if (locale != null) {
    return DateFormat("E. MMM d", locale.toString());
  } else {
    return DateFormat("E. MMM d");
  }
}

extension ClockFormat on int {
  String timeClockFormat() {
    return this >= 10
        ? '$this'
        : this == 0
            ? '00'
            : '0$this';
  }
}
