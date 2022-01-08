import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/core/usecase.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';

class GetSummaryUseCase implements UseCase<List<Country>, void>{
  final CovidRepository _covidRepository;

  GetSummaryUseCase(this._covidRepository);

  @override
  Future<Either<Failure, List<Country>>> call({void params}){
    return _covidRepository.getSummary();
  }
  
}