import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CovidRepositoryImpl implements CovidRepository{
  final CovidApiService _covidApiService;

  CovidRepositoryImpl(this._covidApiService);

  @override
  Future<Either<Failure, List<Country>>> getSummary() async{
    try{
      final httpResponse = await _covidApiService.getSummary();
      return Right(httpResponse.data.countries);
    }on DioError catch(e){
      return Left(Failure(e.message));
    }
  }

}