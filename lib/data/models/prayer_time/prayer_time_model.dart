import 'package:json_annotation/json_annotation.dart';

part 'prayer_time_model.g.dart';

@JsonSerializable()
class PrayerTimeModel {
  int code;
  String status;
  Data data;

  PrayerTimeModel({
    required this.data,
    required this.code,
    required this.status,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrayerTimeModelToJson(this);
}

@JsonSerializable()
class Data {
  Timings timings;
  DatePrayer date;
  Meta meta;

  Data({
    required this.timings,
    required this.date,
    required this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  /// Connect the generated [_$DataToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class DatePrayer {
  String readable;
  String timestamp;
  Hijri hijri;
  Gregorian gregorian;

  DatePrayer({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory DatePrayer.fromJson(Map<String, dynamic> json) =>
      _$DatePrayerFromJson(json);

  /// Connect the generated [_$NameToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DatePrayerToJson(this);
}

@JsonSerializable()
class Gregorian {
  String date;
  String format;
  String day;
  GregorianWeekday weekday;
  GregorianMonth month;
  String year;
  Designation designation;

  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) =>
      _$GregorianFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GregorianToJson(this);
}

@JsonSerializable()
class Designation {
    String abbreviated;
    String expanded;

    Designation({
        required this.abbreviated,
        required this.expanded,
    });

    factory Designation.fromJson(Map<String, dynamic> json) =>
      _$DesignationFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DesignationToJson(this);

}

@JsonSerializable()
class GregorianMonth {
    int number;
    String en;

    GregorianMonth({
        required this.number,
        required this.en,
    });

     factory GregorianMonth.fromJson(Map<String, dynamic> json) =>
      _$GregorianMonthFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GregorianMonthToJson(this);

}

@JsonSerializable()
class GregorianWeekday {
    String en;

    GregorianWeekday({
        required this.en,
    });

 factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      _$GregorianWeekdayFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GregorianWeekdayToJson(this);
}

@JsonSerializable()
class Hijri {
    String date;
    String format;
    String day;
    HijriWeekday weekday;
    HijriMonth month;
    String year;
    Designation designation;
    List<dynamic> holidays;

    Hijri({
        required this.date,
        required this.format,
        required this.day,
        required this.weekday,
        required this.month,
        required this.year,
        required this.designation,
        required this.holidays,
    });

 factory Hijri.fromJson(Map<String, dynamic> json) =>
      _$HijriFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HijriToJson(this);
}

@JsonSerializable()
class HijriMonth {
    int number;
    String en;
    String ar;

    HijriMonth({
        required this.number,
        required this.en,
        required this.ar,
    });

 factory HijriMonth.fromJson(Map<String, dynamic> json) =>
      _$HijriMonthFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HijriMonthToJson(this);
}

@JsonSerializable()
class HijriWeekday {
    String en;
    String ar;

    HijriWeekday({
        required this.en,
        required this.ar,
    });

     factory HijriWeekday.fromJson(Map<String, dynamic> json) =>
      _$HijriWeekdayFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HijriWeekdayToJson(this);

}

@JsonSerializable()
class Meta {
    double latitude;
    double longitude;
    String timezone;
    Method method;
    String latitudeAdjustmentMethod;
    String midnightMode;
    String school;
    Map<String, int> offset;

    Meta({
        required this.latitude,
        required this.longitude,
        required this.timezone,
        required this.method,
        required this.latitudeAdjustmentMethod,
        required this.midnightMode,
        required this.school,
        required this.offset,
    });

     factory Meta.fromJson(Map<String, dynamic> json) =>
      _$MetaFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MetaToJson(this);

}

@JsonSerializable()
class Method {
    int id;
    String name;
    Params params;
    Location location;

    Method({
        required this.id,
        required this.name,
        required this.params,
        required this.location,
    });

     factory Method.fromJson(Map<String, dynamic> json) =>
      _$MethodFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MethodToJson(this);

}

@JsonSerializable()
class Location {
    double latitude;
    double longitude;

    Location({
        required this.latitude,
        required this.longitude,
    });

     factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LocationToJson(this);

}

@JsonSerializable()
class Params {
    int Fajr;
    int Isha;

    Params({
        required this.Fajr,
        required this.Isha,
    });

 factory Params.fromJson(Map<String, dynamic> json) =>
      _$ParamsFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ParamsToJson(this);
}

@JsonSerializable()
class Timings {
    String Fajr;
    String Sunrise;
    String Dhuhr;
    String Asr;
    String Sunset;
    String Maghrib;
    String Isha;
    String Imsak;
    String Midnight;
    String Firstthird;
    String Lastthird;

    Timings({
        required this.Fajr,
        required this.Sunrise,
        required this.Dhuhr,
        required this.Asr,
        required this.Sunset,
        required this.Maghrib,
        required this.Isha,
        required this.Imsak,
        required this.Midnight,
        required this.Firstthird,
        required this.Lastthird,
    });

     factory Timings.fromJson(Map<String, dynamic> json) =>
      _$TimingsFromJson(json);

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TimingsToJson(this);

}




//// end

// @JsonSerializable()
// class Transliteration {
//   String en, id;

//   Transliteration({
//     this.en = '',
//     this.id = '',
//   });

//   factory Transliteration.fromJson(Map<String, dynamic> json) =>
//       _$TransliterationFromJson(json);

//   /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$TransliterationToJson(this);
// }

// @JsonSerializable()
// class Translation {
//   String en, id;

//   Translation({
//     this.en = '',
//     this.id = '',
//   });

//   factory Translation.fromJson(Map<String, dynamic> json) =>
//       _$TranslationFromJson(json);

//   /// Connect the generated [_$TranslationToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$TranslationToJson(this);
// }

// @JsonSerializable()
// class Revelation {
//   String arab, en, id;

//   Revelation({
//     this.en = '',
//     this.id = '',
//     this.arab = '',
//   });

//   factory Revelation.fromJson(Map<String, dynamic> json) =>
//       _$RevelationFromJson(json);

//   /// Connect the generated [_$RevelationToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$RevelationToJson(this);
// }

// @JsonSerializable()
// class Tafsir {
//   String id;

//   Tafsir({required this.id});

//   factory Tafsir.fromJson(Map<String, dynamic> json) => _$TafsirFromJson(json);

//   /// Connect the generated [_$TafsirToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$TafsirToJson(this);
// }
