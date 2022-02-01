import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/data/models/record_model.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';

class TestModels {
  List<Country> get exampleList => [
        const Country(
            updated: 12341234,
            country: "Poland",
            countryCode: "PL",
            flag: "poland",
            cases: 3,
            todayCases: 10,
            todayDeaths: 1,
            deaths: 2,
            todayRecovered: 2,
            recovered: 3),
        const Country(
            updated: 12341234,
            country: "Germany",
            countryCode: "DE",
            flag: "germany",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30)
      ];

  List<CountryModel> get exampleModelList => [
        const CountryModel(
            updated: 12341234,
            country: "Global",
            countryCode: "GL",
            flag: "global",
            cases: 100,
            todayCases: 5000,
            todayDeaths: 23,
            deaths: 67,
            todayRecovered: 2,
            recovered: 32),
        const CountryModel(
            updated: 12341234,
            country: "Poland",
            countryCode: "PL",
            flag: "poland",
            cases: 10,
            todayCases: 200,
            todayDeaths: 40,
            deaths: 70,
            todayRecovered: 0,
            recovered: 3),
        const CountryModel(
            updated: 12341234,
            country: "Germany",
            countryCode: "DE",
            flag: "germany",
            cases: 100,
            todayCases: 3000,
            todayDeaths: 27,
            deaths: 90,
            todayRecovered: 12,
            recovered: 20),
      ];

  List<Country> get exampleListLong => [
        const Country(
            updated: 12341234,
            country: "Poland",
            countryCode: "PL",
            flag: "poland",
            cases: 3,
            todayCases: 10,
            todayDeaths: 1,
            deaths: 2,
            todayRecovered: 2,
            recovered: 3),
        const Country(
            updated: 12341234,
            country: "Germany",
            countryCode: "DE",
            flag: "germany",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30),
        const Country(
            updated: 12341234,
            country: "Denmark",
            countryCode: "D",
            flag: "denmark",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30),
        const Country(
            updated: 12341234,
            country: "Norway",
            countryCode: "NOR",
            flag: "norway",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30),
        const Country(
            updated: 12341234,
            country: "Sweden",
            countryCode: "SW",
            flag: "sweden",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30),
        const Country(
            updated: 12341234,
            country: "Ukraine",
            countryCode: "UR",
            flag: "ukraine",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30),
        const Country(
            updated: 12341234,
            country: "Czechia",
            countryCode: "CZE",
            flag: "czechia",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30),
      ];

  Country get exampleCountry => const CountryModel(
      updated: 12341234,
      country: "Germany",
      countryCode: "DE",
      flag: "germany",
      cases: 100,
      todayCases: 3000,
      todayDeaths: 27,
      deaths: 90,
      todayRecovered: 12,
      recovered: 20);

  Record get exampleRecord => const Record(
      updated: 12341234,
      cases: 3,
      todayCases: 10,
      todayDeaths: 1,
      deaths: 2,
      todayRecovered: 2,
      recovered: 3);

  RecordModel get exampleRecordModel => const RecordModel(
      updated: 12341234,
      cases: 100,
      todayCases: 5000,
      todayDeaths: 23,
      deaths: 67,
      todayRecovered: 2,
      recovered: 32);

  Failure get exampleFailure => Failure("message");

  String get testJson => '''{
    "updated": 1641847925864,
"country": "Afghanistan",
"countryInfo": {
"_id": 4,
"iso2": "AF",
"iso3": "AFG",
"lat": 33,
"long": 65,
"flag": "https://disease.sh/assets/img/flags/af.png"
},
"cases": 158394,
"todayCases": 13,
"deaths": 7373,
"todayDeaths": 0,
"recovered": 145814,
"todayRecovered": 20,
"active": 5207,
"critical": 1124,
"casesPerOneMillion": 3934,
"deathsPerOneMillion": 183,
"tests": 830076,
"testsPerOneMillion": 20618,
"population": 40260483,
"continent": "Asia",
"oneCasePerPeople": 254,
"oneDeathPerPeople": 5461,
"oneTestPerPeople": 49,
"activePerOneMillion": 129.33,
"recoveredPerOneMillion": 3621.76,
"criticalPerOneMillion": 27.92
}''';
}
