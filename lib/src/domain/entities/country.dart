import 'package:covid_app/src/domain/entities/record.dart';

class Country extends Record {
  final String country;
  final String countryCode;
  final String flag;

  const Country(
      {required this.country,
      required this.countryCode,
      required this.flag,
      required int todayCases,
      required int cases,
      required int todayDeaths,
      required int deaths,
      required int todayRecovered,
      required int recovered})
      : super(
            cases: cases,
            todayCases: todayCases,
            todayDeaths: todayDeaths,
            deaths: deaths,
            todayRecovered: todayRecovered,
            recovered: recovered);

  @override
  List<Object?> get props => [
        country,
        countryCode,
        flag,
        cases,
        todayCases,
        todayDeaths,
        deaths,
        todayRecovered,
        recovered
      ];
}
