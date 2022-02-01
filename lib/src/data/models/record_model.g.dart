// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordModel _$RecordModelFromJson(Map<String, dynamic> json) => RecordModel(
      updated: json['updated'] as int,
      todayCases: json['todayCases'] as int,
      cases: json['cases'] as int,
      todayDeaths: json['todayDeaths'] as int,
      deaths: json['deaths'] as int,
      todayRecovered: json['todayRecovered'] as int,
      recovered: json['recovered'] as int,
    );

Map<String, dynamic> _$RecordModelToJson(RecordModel instance) =>
    <String, dynamic>{
      'updated': instance.updated,
      'cases': instance.cases,
      'todayCases': instance.todayCases,
      'todayDeaths': instance.todayDeaths,
      'deaths': instance.deaths,
      'todayRecovered': instance.todayRecovered,
      'recovered': instance.recovered,
    };
