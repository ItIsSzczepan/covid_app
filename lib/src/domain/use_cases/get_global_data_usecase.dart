import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/core/usecase.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';

class GetGlobalDataUseCase implements UseCase<Record, void>{
  final CovidRepository _covidRepository;

  GetGlobalDataUseCase(this._covidRepository);

  @override
  Future<Either<Failure, Record>> call({params}) {
    return _covidRepository.getGlobal();
  }
}