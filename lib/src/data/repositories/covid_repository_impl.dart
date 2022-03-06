import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/data/data_sources/local/app_database.dart';
import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CovidRepositoryImpl implements CovidRepository{
  final CovidApiService _covidApiService;
  final AppDatabase _appDatabase;

  CovidRepositoryImpl(this._covidApiService, this._appDatabase);

  @override
  Future<Either<Failure, List<Country>>> getAllCountriesListData() async{
    try{
      final httpResponse = await _covidApiService.getAllCountriesList();
      _updatedCountriesInDatabase(httpResponse.data);
      return Right(httpResponse.data);
    }on DioError catch(e){
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Record>> getGlobal() async{
    try{
      final httpResponse = await _covidApiService.getGlobal();
      return Right(httpResponse.data);
    }on DioError catch(e){
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Country>>>> getAllFavoritesCountries() async {
    try{
      var result = _appDatabase.countryDao.findALlCountriesStream();
      return Right(result);
    }catch (e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addCountryToFavorites(Country country) async {
    try{
      final result = await _appDatabase.countryDao.insertCountry(country);
      return Right(result);
    }catch (e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeCountryFromFavorites(Country country) async {
    try{
      final result = await _appDatabase.countryDao.deleteCountry(country);
      return Right(result);
    }catch (e){
      return Left(Failure(e.toString()));
    }
  }

  _updatedCountriesInDatabase(List<Country> downloadedCountries) async {
    var countriesInDB = await _appDatabase.countryDao.findALlCountries();
    if(countriesInDB.isEmpty) return null;

    for (var downloadedCountry in downloadedCountries) {
      for (var inDBCountry in countriesInDB) {
        if(downloadedCountry.country == inDBCountry.country){
          _appDatabase.countryDao.updateCountry(downloadedCountry);
        }
      }
    }
  }

}