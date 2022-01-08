// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordModel _$RecordModelFromJson(Map<String, dynamic> json) => RecordModel(
      json['newConfirmed'],
      json['totalConfirmed'],
      json['newDeaths'],
      json['totalDeaths'],
      json['newRecovered'],
      json['totalRecovered'],
    );

Map<String, dynamic> _$RecordModelToJson(RecordModel instance) =>
    <String, dynamic>{
      'newConfirmed': instance.newConfirmed,
      'totalConfirmed': instance.totalConfirmed,
      'newDeaths': instance.newDeaths,
      'totalDeaths': instance.totalDeaths,
      'newRecovered': instance.newRecovered,
      'totalRecovered': instance.totalRecovered,
    };
