import 'dart:io';

import 'package:covid_app/src/core/constant.dart';
import 'package:covid_app/src/data/data_sources/local/app_database.dart';
import 'package:covid_app/src/data/data_sources/local/country_dao.dart';
import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/data/models/record_model.dart';
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

@GenerateMocks([CovidApiService, AppDatabase, CountryDao])
void main() {
  late CovidRepositoryImpl covidRepositoryImpl;
  late MockCovidApiService mockCovidApiService;
  late MockAppDatabase mockAppDatabase;
  late MockCountryDao mockCountryDao;

  setUp(() {
    mockCovidApiService = MockCovidApiService();
    mockAppDatabase = MockAppDatabase();
    mockCountryDao = MockCountryDao();
    covidRepositoryImpl =
        CovidRepositoryImpl(mockCovidApiService, mockAppDatabase);
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

  Country testCountry = const CountryModel(
      country: "Germany",
      countryCode: "DE",
      flag: "germany",
      cases: 100,
      todayCases: 3000,
      todayDeaths: 27,
      deaths: 90,
      todayRecovered: 12,
      recovered: 20);

  RecordModel exampleRecord = const RecordModel(
      cases: 100,
      todayCases: 5000,
      todayDeaths: 23,
      deaths: 67,
      todayRecovered: 2,
      recovered: 32);

  test("test getAllCountriesList", () async {
    when(mockCovidApiService.getAllCountriesList()).thenAnswer((_) async =>
        HttpResponse(
            exampleList,
            Response(
                requestOptions: RequestOptions(
                    path: "https://disease.sh/v3/covid-19/countries"))));
    final result = await covidRepositoryImpl.getAllCountriesListData();

    expect(result, Right(exampleList));

    verify(mockCovidApiService.getAllCountriesList());
    verifyNoMoreInteractions(mockCovidApiService);
  });

  test("test getGlobal", () async {
    when(mockCovidApiService.getGlobal()).thenAnswer((_) async => HttpResponse(
        exampleRecord,
        Response(
            requestOptions:
                RequestOptions(path: "https://disease.sh/v3/covid-19/all"))));
    final result = await covidRepositoryImpl.getGlobal();

    expect(result, Right(exampleRecord));

    verify(mockCovidApiService.getGlobal());
    verifyNoMoreInteractions(mockCovidApiService);
  });

  test("getAllFavoritesCountries should return list of countries", () async {
    when(mockAppDatabase.countryDao).thenReturn(mockCountryDao);
    when(mockCountryDao.findALlCountries())
        .thenAnswer((_) async => exampleList);

    final result = await covidRepositoryImpl.getAllFavoritesCountries();

    expect(result, Right(exampleList));

    verify(mockCountryDao.findALlCountries());
    verify(mockAppDatabase.countryDao);

    verifyNoMoreInteractions(mockCountryDao);
    verifyNoMoreInteractions(mockAppDatabase);

    verifyZeroInteractions(mockCovidApiService);
  });

  test("test addCountryToFavorites", () async {
    when(mockAppDatabase.countryDao).thenReturn(mockCountryDao);
    when(mockCountryDao.insertCountry(testCountry)).thenAnswer((value) async {
      exampleList.add(value.positionalArguments.first);
    });

    final result = await covidRepositoryImpl.addCountryToFavorites(testCountry);

    expect(result, const Right(null));

    verify(mockCountryDao.insertCountry(testCountry));
    verify(mockAppDatabase.countryDao);

    verifyNoMoreInteractions(mockCountryDao);
    verifyNoMoreInteractions(mockAppDatabase);

    verifyZeroInteractions(mockCovidApiService);

    when(mockCountryDao.findALlCountries())
        .thenAnswer((realInvocation) async => exampleList);

    final result2 = await covidRepositoryImpl.getAllFavoritesCountries();

    expect(result2, Right(exampleList));
  });

  test("removeCountryFromFavorites should remove country", () async {
    when(mockAppDatabase.countryDao).thenReturn(mockCountryDao);
    when(mockCountryDao.findALlCountries())
        .thenAnswer((_) async => exampleList);
    when(mockCountryDao.deleteCountry(testCountry))
        .thenAnswer((realInvocation) async {
      exampleList.remove(realInvocation.positionalArguments.first);
    });

    final result =
        await covidRepositoryImpl.removeCountryFromFavorites(testCountry);

    expect(result, const Right(null));

    verify(mockCountryDao.deleteCountry(testCountry));
    verify(mockAppDatabase.countryDao);

    verifyNoMoreInteractions(mockCountryDao);
    verifyNoMoreInteractions(mockAppDatabase);

    verifyZeroInteractions(mockCovidApiService);

    final result2 = await covidRepositoryImpl.getAllFavoritesCountries();

    expect(result2, Right(exampleList));
  });
}
