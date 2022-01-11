import 'package:covid_app/src/data/models/record_model.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel extends Country {
  @JsonKey(name: 'iso2', readValue: readCountryInfo, defaultValue: "")
  final String countryCode;
  @JsonKey(name: 'flag', readValue: readCountryInfo, defaultValue: "")
  final String flag;

  const CountryModel(
      {required String country,
      required this.countryCode,
      required this.flag,
      required int todayCases,
      required int cases,
      required int todayDeaths,
      required int deaths,
      required int todayRecovered,
      required int recovered})
      : super(
            country: country,
            countryCode: countryCode,
            flag: flag,
            cases: cases,
            todayCases: todayCases,
            todayDeaths: todayDeaths,
            deaths: deaths,
            todayRecovered: todayRecovered,
            recovered: recovered);

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  static Object? readCountryInfo(Map json, String name) {
    return json['countryInfo'][name];
  }
}
