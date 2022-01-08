// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      country: json['country'],
      countryCode: json['countryCode'],
      slug: json['slug'],
      record: json['record'],
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'countryCode': instance.countryCode,
      'slug': instance.slug,
      'record': instance.record,
    };
