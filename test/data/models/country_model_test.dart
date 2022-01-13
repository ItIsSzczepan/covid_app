import 'dart:convert';

import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/data/models/record_model.dart';
import 'package:flutter_test/flutter_test.dart';

const String testJson = '''{
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

void main() {
  late Map<String, dynamic> json;
  late CountryModel model;

  setUp((){
    json = jsonDecode(testJson);
    model = CountryModel.fromJson(json);
  });

  test("Check if fromJson return object of RecordModel class", (){
    expect(model, isInstanceOf<CountryModel>());
  });

  test("method fromJson should return country name", () {
    expect(model.country, "Afghanistan");
    expect(model.country, isA<String>());
  });

  test("method fromJson should return country id", () {
    expect(model.id, 4);
    expect(model.id, isA<int>());
  });

  test("method fromJson should return country code", () {
    expect(model.countryCode, "AF");
    expect(model.countryCode, isA<String>());
  });

  test("method fromJson should return flag", () {
    expect(model.flag, "https://disease.sh/assets/img/flags/af.png");
    expect(model.flag, isA<String>());
  });

  test("method fromJson should return right number of cases", () {
    expect(model.cases, 158394);
    expect(model.cases, isA<int>());
  });

  test("method fromJson should return right number of today cases", () {
    expect(model.todayCases, 13);
    expect(model.todayCases, isA<int>());
  });

  test("method fromJson should return right number of deaths", () {
    expect(model.deaths, 7373);
    expect(model.deaths, isA<int>());
  });

  test("method fromJson should return right number of today deaths", () {
    expect(model.todayDeaths, 0);
    expect(model.todayDeaths, isA<int>());
  });

  test("method fromJson should return right number of recovered", () {
    expect(model.recovered, 145814);
    expect(model.recovered, isA<int>());
  });

  test("method fromJson should return right number of today recovered", () {
    expect(model.todayRecovered, 20);
    expect(model.todayRecovered, isA<int>());
  });
}
