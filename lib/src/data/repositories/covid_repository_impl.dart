import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/data/data_sources/local/app_database.dart';
import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CovidRepositoryImpl implements CovidRepository{
  final CovidApiService _covidApiService;
  final AppDatabase _appDatabase;

  CovidRepositoryImpl(this._covidApiService, this._appDatabase);

  @override
  Future<Either<Failure, List<Country>>> getAllCountriesListData() async{
    try{
      final httpResponse = await _covidApiService.getAllCountriesList();
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
  Future<Either<Failure, List<Country>>> getAllFavoritesCountries() async {
    try{
      final result = await _appDatabase.countryDao.findALlCountries();
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

}