import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/core/params.dart';
import 'package:covid_app/src/core/usecase.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';

class GetFavoritesCountriesUseCase implements UseCase<Stream<List<Country>>, Params>{
  final CovidRepository _covidRepository;

  GetFavoritesCountriesUseCase(this._covidRepository);

  @override
  Future<Either<Failure, Stream<List<Country>>>> call({Params? params}) {
    return _covidRepository.getAllFavoritesCountries();
  }
}