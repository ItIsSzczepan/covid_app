import 'dart:convert';

import 'package:covid_app/src/data/models/record_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../models.dart';

void main() {
  late Map<String, dynamic> json;
  late RecordModel model;

  setUp(() {
    json = jsonDecode(TestModels().testJson);
    model = RecordModel.fromJson(json);
  });

  test("Check if fromJson return object of RecordModel class", () {
    expect(model, isInstanceOf<RecordModel>());
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
