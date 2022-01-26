import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:dartz/dartz.dart';

abstract class CovidRepository{
  // API
  Future<Either<Failure, List<Country>>> getAllCountriesListData();
  Future<Either<Failure, Record>> getGlobal();

  // DATABASE
  Future<Either<Failure, Stream<List<Country>>>> getAllFavoritesCountries();
  Future<Either<Failure, void>> addCountryToFavorites(Country country);
  Future<Either<Failure, void>> removeCountryFromFavorites(Country country);
}