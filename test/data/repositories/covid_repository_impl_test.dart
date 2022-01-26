import 'dart:async';

import 'package:covid_app/src/data/data_sources/local/app_database.dart';
import 'package:covid_app/src/data/data_sources/local/country_dao.dart';
import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/data/repositories/covid_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import '../../models.dart';
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

  List<CountryModel> exampleList = TestModels().exampleModelList;

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
        TestModels().exampleRecordModel,
        Response(
            requestOptions:
                RequestOptions(path: "https://disease.sh/v3/covid-19/all"))));
    final result = await covidRepositoryImpl.getGlobal();

    expect(result, Right(TestModels().exampleRecordModel));

    verify(mockCovidApiService.getGlobal());
    verifyNoMoreInteractions(mockCovidApiService);
  });

  test("getAllFavoritesCountries should return list of countries", () async {
    when(mockAppDatabase.countryDao).thenReturn(mockCountryDao);
    when(mockCountryDao.findALlCountriesStream())
        .thenAnswer((_) => Stream.value(exampleList));

    final result = await covidRepositoryImpl.getAllFavoritesCountries();

    expect(result.isRight(), true);
    expect(result, isInstanceOf<Right<dynamic, Stream>>());

    verify(mockCountryDao.findALlCountriesStream());
    verify(mockAppDatabase.countryDao);

    verifyNoMoreInteractions(mockCountryDao);
    verifyNoMoreInteractions(mockAppDatabase);

    verifyZeroInteractions(mockCovidApiService);
  });

  test("test addCountryToFavorites", () async {
    when(mockAppDatabase.countryDao).thenReturn(mockCountryDao);
    when(mockCountryDao.insertCountry(TestModels().exampleCountry))
        .thenAnswer((value) async {
      exampleList.add(value.positionalArguments.first);
    });

    final result = await covidRepositoryImpl
        .addCountryToFavorites(TestModels().exampleCountry);

    expect(result, const Right(null));

    verify(mockCountryDao.insertCountry(TestModels().exampleCountry));
    verify(mockAppDatabase.countryDao);

    verifyNoMoreInteractions(mockCountryDao);
    verifyNoMoreInteractions(mockAppDatabase);

    verifyZeroInteractions(mockCovidApiService);

    when(mockCountryDao.findALlCountries())
        .thenAnswer((realInvocation) async => exampleList);

    final result2 = await mockAppDatabase.countryDao.findALlCountries();

    expect(result2, exampleList);
  });

  test("removeCountryFromFavorites should remove country", () async {
    when(mockAppDatabase.countryDao).thenReturn(mockCountryDao);
    when(mockCountryDao.findALlCountries())
        .thenAnswer((_) async => exampleList);
    when(mockCountryDao.deleteCountry(TestModels().exampleCountry))
        .thenAnswer((realInvocation) async {
      exampleList.remove(realInvocation.positionalArguments.first);
    });

    final result = await covidRepositoryImpl
        .removeCountryFromFavorites(TestModels().exampleCountry);

    expect(result, const Right(null));

    verify(mockCountryDao.deleteCountry(TestModels().exampleCountry));
    verify(mockAppDatabase.countryDao);

    verifyNoMoreInteractions(mockCountryDao);
    verifyNoMoreInteractions(mockAppDatabase);

    verifyZeroInteractions(mockCovidApiService);

    final result2 = await mockAppDatabase.countryDao.findALlCountries();

    expect(result2, exampleList);
  });
}
