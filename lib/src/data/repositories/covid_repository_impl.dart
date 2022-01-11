import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CovidRepositoryImpl implements CovidRepository{
  final CovidApiService _covidApiService;

  CovidRepositoryImpl(this._covidApiService);

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
  Future<Either<Failure, Record>> getGlobal() {
    // TODO: implement getGlobal
    throw UnimplementedError();
  }

}