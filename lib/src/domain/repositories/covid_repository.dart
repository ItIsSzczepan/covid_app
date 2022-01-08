import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:dartz/dartz.dart';

abstract class CovidRepository{
  // API
  Future<Either<Failure, List<Country>>> getSummary();
}