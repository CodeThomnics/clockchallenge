// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TimeZone extends Equatable {
  String? abbreviation;
  String? clientIp;
  DateTime? datetime;
  int? dayOfWeek;
  int? dayOfYear;
  bool? dst;
  String? dstFrom;
  int dstOffset;
  String? dstUntil;
  int rawOffset;
  String timezone;
  int? unixtime;
  DateTime? utcDatetime;
  String? utcOffset;
  int? weekNumber;

  TimeZone({
    this.abbreviation,
    this.clientIp,
    this.datetime,
    this.dayOfWeek,
    this.dayOfYear,
    this.dst,
    this.dstFrom,
    this.dstOffset = 0,
    this.dstUntil,
    this.rawOffset = 0,
    this.timezone = '',
    this.unixtime,
    this.utcDatetime,
    this.utcOffset,
    this.weekNumber,
  });

  TimeZone copyWith({
    String? abbreviation,
    String? clientIp,
    DateTime? datetime,
    int? dayOfWeek,
    int? dayOfYear,
    bool? dst,
    String? dstFrom,
    int? dstOffset,
    String? dstUntil,
    int? rawOffset,
    String? timezone,
    int? unixtime,
    DateTime? utcDatetime,
    String? utcOffset,
    int? weekNumber,
  }) {
    return TimeZone(
      abbreviation: abbreviation ?? this.abbreviation,
      clientIp: clientIp ?? this.clientIp,
      datetime: datetime ?? this.datetime,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      dayOfYear: dayOfYear ?? this.dayOfYear,
      dst: dst ?? this.dst,
      dstFrom: dstFrom ?? this.dstFrom,
      dstOffset: dstOffset ?? this.dstOffset,
      dstUntil: dstUntil ?? this.dstUntil,
      rawOffset: rawOffset ?? this.rawOffset,
      timezone: timezone ?? this.timezone,
      unixtime: unixtime ?? this.unixtime,
      utcDatetime: utcDatetime ?? this.utcDatetime,
      utcOffset: utcOffset ?? this.utcOffset,
      weekNumber: weekNumber ?? this.weekNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abbreviation': abbreviation,
      'clientIp': clientIp,
      'datetime': datetime?.toIso8601String(),
      'dayOfWeek': dayOfWeek,
      'dayOfYear': dayOfYear,
      'dst': dst,
      'dstFrom': dstFrom,
      'dstOffset': dstOffset,
      'dstUntil': dstUntil,
      'rawOffset': rawOffset,
      'timezone': timezone,
      'unixtime': unixtime,
      'utcDatetime': utcDatetime?.toIso8601String(),
      'utcOffset': utcOffset,
      'weekNumber': weekNumber,
    };
  }

  factory TimeZone.fromJson(Map<String, dynamic> map) {
    return TimeZone(
      abbreviation: map['abbreviation'],
      clientIp: map['clientIp'],
      datetime:
          map['datetime'] != null ? DateTime.parse(map['datetime']) : null,
      dayOfWeek: map['day_of_week']?.toInt(),
      dayOfYear: map['day_of_year']?.toInt(),
      dst: map['dst'],
      dstFrom: map['dst_from'],
      dstOffset: map['dst_offset']?.toInt() ?? 0,
      dstUntil: map['dst_until'],
      rawOffset: map['raw_offset']?.toInt() ?? 0,
      timezone: map['timezone'] ?? '',
      unixtime: map['unixtime']?.toInt(),
      utcDatetime: map['utc_datetime'] != null
          ? DateTime.parse(map['utc_datetime'])
          : null,
      utcOffset: map['utc_offset'],
      weekNumber: map['week_number'],
    );
  }

  @override
  String toString() {
    return 'TimeZone(abbreviation: $abbreviation, clientIp: $clientIp, datetime: $datetime, dayOfWeek: $dayOfWeek, dayOfYear: $dayOfYear, dst: $dst, dstFrom: $dstFrom, dstOffset: $dstOffset, dstUntil: $dstUntil, rawOffset: $rawOffset, timezone: $timezone, unixtime: $unixtime, utcDatetime: $utcDatetime, utcOffset: $utcOffset, weekNumber: $weekNumber)';
  }

  @override
  List<Object?> get props => [
        abbreviation,
        clientIp,
        datetime,
        dayOfWeek,
        dayOfYear,
        dst,
        dstFrom,
        dstOffset,
        dstUntil,
        rawOffset,
        timezone,
        unixtime,
        utcDatetime,
        utcOffset,
        weekNumber,
      ];
}
