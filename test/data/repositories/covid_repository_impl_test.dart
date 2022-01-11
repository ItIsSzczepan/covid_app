import 'dart:io';

import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/data/repositories/covid_repository_impl.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'covid_repository_impl_test.mocks.dart';

@GenerateMocks([CovidApiService])
void main() {
  late CovidRepositoryImpl covidRepositoryImpl;
  late MockCovidApiService mockCovidApiService;

  setUp(() {
    mockCovidApiService = MockCovidApiService();
    covidRepositoryImpl = CovidRepositoryImpl(mockCovidApiService);
  });

  List<CountryModel> exampleList = [
    const CountryModel(
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

  test("description", () async {
    when(mockCovidApiService.getAllCountriesList()).thenAnswer((_) async => HttpResponse(
        exampleList,
        Response(
            requestOptions:
                RequestOptions(path: "https://api.covid19api.com/summary"))));
    final result = await covidRepositoryImpl.getAllCountriesListData();

    expect(result, Right(exampleList));
  });
}
