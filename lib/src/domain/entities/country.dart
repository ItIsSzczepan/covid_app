import 'package:covid_app/src/core/constant.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:floor/floor.dart';

@Entity(tableName: kCountryTableName)
class Country extends Record {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String country;
  final String countryCode;
  final String flag;

  const Country(
      {required this.country,
      required this.countryCode,
      required this.flag,
      required int updated,
      required int todayCases,
      required int cases,
      required int todayDeaths,
      required int deaths,
      required int todayRecovered,
      required int recovered,
      this.id})
      : super(
            updated: updated,
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
        updated,
        cases,
        todayCases,
        todayDeaths,
        deaths,
        todayRecovered,
        recovered
      ];
}
