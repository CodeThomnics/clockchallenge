import 'dart:convert';

import 'package:clockchallange/models/timezone.dart';
import 'package:http/http.dart' as http;

class WorldTimeAPIService {
  static const String baseUrl = "worldtimeapi.org";

  Future<TimeZone> getCurrentTimezone() async {
    var response = await http.get(Uri.https(baseUrl, "ip"));

    if (response.statusCode == 200) {
      return TimeZone.fromJson(response.body);
    }
    return TimeZone(
        abbreviation: "CET",
        clientIp: "185.10.158.5",
        datetime: DateTime.now(),
        dayOfWeek: 5,
        dayOfYear: 328,
        dst: false,
        dstFrom: null,
        dstOffset: 0,
        dstUntil: null,
        rawOffset: 3600,
        timezone: "Europe/Amsterdam",
        unixtime: 1700828670,
        utcDatetime: DateTime.now(),
        utcOffset: "+01:00",
        weekNumber: 47);
  }

  Future<TimeZone> getTimezone(String timeZone) async {
    var response = await http.get(Uri.http(baseUrl, "api/$timeZone"));
    if (response.statusCode == 200) {
      return TimeZone.fromJson(response.body);
    }
    return TimeZone();
  }

  Future<List<String>> getAllTimezones() async {
    var response = await http.get(Uri.http(baseUrl, "api/timezone"));
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body));
    }
    return [];
  }
}
