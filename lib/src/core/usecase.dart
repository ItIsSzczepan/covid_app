import 'package:covid_app/src/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, P>{
  Future<Either<Failure, T>> call({required P params});
}