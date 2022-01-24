import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/core/usecase.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveCountryFromFavoritesUseCase implements UseCase<void, Country>{
  final CovidRepository _covidRepository;

  RemoveCountryFromFavoritesUseCase(this._covidRepository);

  @override
  Future<Either<Failure, void>> call({required Country params}) {
    return _covidRepository.removeCountryFromFavorites(params);
  }

}