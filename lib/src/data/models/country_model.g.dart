// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
    country: json['Country'],
    countryCode: json['CountryCode'],
    slug: json['Slug'],
    record: RecordModel(
        json['NewConfirmed'] as int,
        json['TotalConfirmed'] as int,
        json['NewDeaths'] as int,
        json['TotalDeaths'] as int,
        json['NewRecovered'],
        json['TotalRecovered'] as int));

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'countryCode': instance.countryCode,
      'slug': instance.slug,
      'record': instance.record,
    };
