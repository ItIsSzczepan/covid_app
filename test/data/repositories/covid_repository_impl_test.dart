import 'dart:io';

import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/data/models/get_summary_response.dart';
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

  List<Country> exampleList = [
    const Country(
        country: "Global",
        countryCode: "GL",
        slug: "global",
        record: Record(
            newConfirmed: 100,
            totalConfirmed: 5000,
            newDeaths: 23,
            totalDeaths: 67,
            newRecovered: 2,
            totalRecovered: 32)),
    const Country(
        country: "Poland",
        countryCode: "PL",
        slug: "poland",
        record: Record(
            newConfirmed: 10,
            totalConfirmed: 200,
            newDeaths: 40,
            totalDeaths: 70,
            newRecovered: 0,
            totalRecovered: 3)),
    const Country(
        country: "Germany",
        countryCode: "DE",
        slug: "germany",
        record: Record(
            newConfirmed: 100,
            totalConfirmed: 3000,
            newDeaths: 27,
            totalDeaths: 90,
            newRecovered: 12,
            totalRecovered: 20)),
  ];

  test("description", () async {
    when(mockCovidApiService.getSummary()).thenAnswer((_) async => HttpResponse(
        GetSummaryResponse(countries: exampleList),
        Response(
            requestOptions:
                RequestOptions(path: "https://api.covid19api.com/summary"))));
    final result = await covidRepositoryImpl.getSummary();

    expect(result, Right(exampleList));
  });
}
