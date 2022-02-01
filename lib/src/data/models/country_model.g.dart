// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      country: json['country'] as String,
      countryCode: CountryModel.readCountryInfo(json, 'iso2') as String? ?? '',
      flag: CountryModel.readCountryInfo(json, 'flag') as String? ?? '',
      updated: json['updated'] as int,
      todayCases: json['todayCases'] as int,
      cases: json['cases'] as int,
      todayDeaths: json['todayDeaths'] as int,
      deaths: json['deaths'] as int,
      todayRecovered: json['todayRecovered'] as int,
      recovered: json['recovered'] as int,
      id: CountryModel.readCountryInfo(json, '_id') as int?,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'updated': instance.updated,
      'cases': instance.cases,
      'todayCases': instance.todayCases,
      'todayDeaths': instance.todayDeaths,
      'deaths': instance.deaths,
      'todayRecovered': instance.todayRecovered,
      'recovered': instance.recovered,
      'country': instance.country,
      '_id': instance.id,
      'iso2': instance.countryCode,
      'flag': instance.flag,
    };
