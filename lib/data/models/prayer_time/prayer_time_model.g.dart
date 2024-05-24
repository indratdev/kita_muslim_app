// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrayerTimeModel _$PrayerTimeModelFromJson(Map<String, dynamic> json) =>
    PrayerTimeModel(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PrayerTimeModelToJson(PrayerTimeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      timings: Timings.fromJson(json['timings'] as Map<String, dynamic>),
      date: DatePrayer.fromJson(json['date'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'timings': instance.timings,
      'date': instance.date,
      'meta': instance.meta,
    };

DatePrayer _$DatePrayerFromJson(Map<String, dynamic> json) => DatePrayer(
      readable: json['readable'] as String,
      timestamp: json['timestamp'] as String,
      hijri: Hijri.fromJson(json['hijri'] as Map<String, dynamic>),
      gregorian: Gregorian.fromJson(json['gregorian'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatePrayerToJson(DatePrayer instance) =>
    <String, dynamic>{
      'readable': instance.readable,
      'timestamp': instance.timestamp,
      'hijri': instance.hijri,
      'gregorian': instance.gregorian,
    };

Gregorian _$GregorianFromJson(Map<String, dynamic> json) => Gregorian(
      date: json['date'] as String,
      format: json['format'] as String,
      day: json['day'] as String,
      weekday:
          GregorianWeekday.fromJson(json['weekday'] as Map<String, dynamic>),
      month: GregorianMonth.fromJson(json['month'] as Map<String, dynamic>),
      year: json['year'] as String,
      designation:
          Designation.fromJson(json['designation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GregorianToJson(Gregorian instance) => <String, dynamic>{
      'date': instance.date,
      'format': instance.format,
      'day': instance.day,
      'weekday': instance.weekday,
      'month': instance.month,
      'year': instance.year,
      'designation': instance.designation,
    };

Designation _$DesignationFromJson(Map<String, dynamic> json) => Designation(
      abbreviated: json['abbreviated'] as String,
      expanded: json['expanded'] as String,
    );

Map<String, dynamic> _$DesignationToJson(Designation instance) =>
    <String, dynamic>{
      'abbreviated': instance.abbreviated,
      'expanded': instance.expanded,
    };

GregorianMonth _$GregorianMonthFromJson(Map<String, dynamic> json) =>
    GregorianMonth(
      number: json['number'] as int,
      en: json['en'] as String,
    );

Map<String, dynamic> _$GregorianMonthToJson(GregorianMonth instance) =>
    <String, dynamic>{
      'number': instance.number,
      'en': instance.en,
    };

GregorianWeekday _$GregorianWeekdayFromJson(Map<String, dynamic> json) =>
    GregorianWeekday(
      en: json['en'] as String,
    );

Map<String, dynamic> _$GregorianWeekdayToJson(GregorianWeekday instance) =>
    <String, dynamic>{
      'en': instance.en,
    };

Hijri _$HijriFromJson(Map<String, dynamic> json) => Hijri(
      date: json['date'] as String,
      format: json['format'] as String,
      day: json['day'] as String,
      weekday: HijriWeekday.fromJson(json['weekday'] as Map<String, dynamic>),
      month: HijriMonth.fromJson(json['month'] as Map<String, dynamic>),
      year: json['year'] as String,
      designation:
          Designation.fromJson(json['designation'] as Map<String, dynamic>),
      holidays: json['holidays'] as List<dynamic>,
    );

Map<String, dynamic> _$HijriToJson(Hijri instance) => <String, dynamic>{
      'date': instance.date,
      'format': instance.format,
      'day': instance.day,
      'weekday': instance.weekday,
      'month': instance.month,
      'year': instance.year,
      'designation': instance.designation,
      'holidays': instance.holidays,
    };

HijriMonth _$HijriMonthFromJson(Map<String, dynamic> json) => HijriMonth(
      number: json['number'] as int,
      en: json['en'] as String,
      ar: json['ar'] as String,
    );

Map<String, dynamic> _$HijriMonthToJson(HijriMonth instance) =>
    <String, dynamic>{
      'number': instance.number,
      'en': instance.en,
      'ar': instance.ar,
    };

HijriWeekday _$HijriWeekdayFromJson(Map<String, dynamic> json) => HijriWeekday(
      en: json['en'] as String,
      ar: json['ar'] as String,
    );

Map<String, dynamic> _$HijriWeekdayToJson(HijriWeekday instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ar': instance.ar,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone'] as String,
      method: Method.fromJson(json['method'] as Map<String, dynamic>),
      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'] as String,
      midnightMode: json['midnightMode'] as String,
      school: json['school'] as String,
      offset: Map<String, int>.from(json['offset'] as Map),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timezone': instance.timezone,
      'method': instance.method,
      'latitudeAdjustmentMethod': instance.latitudeAdjustmentMethod,
      'midnightMode': instance.midnightMode,
      'school': instance.school,
      'offset': instance.offset,
    };

Method _$MethodFromJson(Map<String, dynamic> json) => Method(
      id: json['id'] as int,
      name: json['name'] as String,
      params: Params.fromJson(json['params'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MethodToJson(Method instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'params': instance.params,
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Params _$ParamsFromJson(Map<String, dynamic> json) => Params(
      Fajr: json['Fajr'] as int,
      Isha: json['Isha'] as int,
    );

Map<String, dynamic> _$ParamsToJson(Params instance) => <String, dynamic>{
      'Fajr': instance.Fajr,
      'Isha': instance.Isha,
    };

Timings _$TimingsFromJson(Map<String, dynamic> json) => Timings(
      Fajr: json['Fajr'] as String,
      Sunrise: json['Sunrise'] as String,
      Dhuhr: json['Dhuhr'] as String,
      Asr: json['Asr'] as String,
      Sunset: json['Sunset'] as String,
      Maghrib: json['Maghrib'] as String,
      Isha: json['Isha'] as String,
      Imsak: json['Imsak'] as String,
      Midnight: json['Midnight'] as String,
      Firstthird: json['Firstthird'] as String,
      Lastthird: json['Lastthird'] as String,
    );

Map<String, dynamic> _$TimingsToJson(Timings instance) => <String, dynamic>{
      'Fajr': instance.Fajr,
      'Sunrise': instance.Sunrise,
      'Dhuhr': instance.Dhuhr,
      'Asr': instance.Asr,
      'Sunset': instance.Sunset,
      'Maghrib': instance.Maghrib,
      'Isha': instance.Isha,
      'Imsak': instance.Imsak,
      'Midnight': instance.Midnight,
      'Firstthird': instance.Firstthird,
      'Lastthird': instance.Lastthird,
    };
