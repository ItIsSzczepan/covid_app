import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/core/params.dart';
import 'package:covid_app/src/core/usecase.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCountriesListDataUseCase implements UseCase<List<Country>, Params>{
  final CovidRepository _covidRepository;

  GetAllCountriesListDataUseCase(this._covidRepository);

  @override
  Future<Either<Failure, List<Country>>> call({Params? params}){
    return _covidRepository.getAllCountriesListData();
  }
  
}