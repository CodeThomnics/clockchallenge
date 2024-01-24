// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class AlarmModel extends Equatable {
  String id;

  String name;

  int hour;

  int minute;

  bool monday;

  bool tuesday;

  bool wednesday;

  bool thursday;

  bool friday;

  bool saturday;

  bool sunday;

  double volume;

  bool progressiveVolume;

  bool active;

  AlarmModel({
    this.id = '',
    this.name = '',
    this.hour = 0,
    this.minute = 0,
    this.monday = false,
    this.tuesday = false,
    this.wednesday = false,
    this.thursday = false,
    this.friday = false,
    this.saturday = false,
    this.sunday = false,
    this.volume = 0,
    this.progressiveVolume = false,
    this.active = false,
  });

  factory AlarmModel.fromJson(Map<String, dynamic> json) => AlarmModel(
        id: json['id'],
        name: json['name'],
        hour: json['hour'],
        minute: json['minute'],
        monday: json['monday'],
        tuesday: json['tuesday'],
        wednesday: json['wednesday'],
        thursday: json['thursday'],
        friday: json['friday'],
        saturday: json['saturday'],
        sunday: json['sunday'],
        volume: json['volume'],
        progressiveVolume: json['progressiveVolume'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hour': hour,
      'minute': minute,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
      'volume': volume,
      'progressiveVolume': progressiveVolume,
      'active': active,
    };
  }

  AlarmModel copyWith({
    String? id,
    String? name,
    int? hour,
    int? minute,
    bool? monday,
    bool? tuesday,
    bool? wednesday,
    bool? thursday,
    bool? friday,
    bool? saturday,
    bool? sunday,
    double? volume,
    bool? progressiveVolume,
    bool? active,
  }) {
    return AlarmModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
      volume: volume ?? this.volume,
      progressiveVolume: progressiveVolume ?? this.progressiveVolume,
      active: active ?? this.active,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        hour,
        minute,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday,
        volume,
        progressiveVolume,
        active,
      ];

  @override
  bool get stringify => true;
}
