// Mocks generated by Mockito 5.0.17 from annotations
// in covid_app/test/domain/use_cases/get_global_data_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:covid_app/src/core/failure.dart' as _i5;
import 'package:covid_app/src/domain/entities/country.dart' as _i6;
import 'package:covid_app/src/domain/entities/record.dart' as _i7;
import 'package:covid_app/src/domain/repositories/covid_repository.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [CovidRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCovidRepository extends _i1.Mock implements _i3.CovidRepository {
  MockCovidRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Country>>>
      getAllCountriesListData() => (super.noSuchMethod(
          Invocation.method(#getAllCountriesListData, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Country>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Country>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Country>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.Record>> getGlobal() =>
      (super.noSuchMethod(Invocation.method(#getGlobal, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i7.Record>>.value(
                  _FakeEither_0<_i5.Failure, _i7.Record>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i7.Record>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i4.Stream<List<_i6.Country>>>>
      getAllFavoritesCountries() => (super.noSuchMethod(
          Invocation.method(#getAllFavoritesCountries, []),
          returnValue: Future<
                  _i2.Either<_i5.Failure, _i4.Stream<List<_i6.Country>>>>.value(
              _FakeEither_0<_i5.Failure, _i4.Stream<List<_i6.Country>>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i4.Stream<List<_i6.Country>>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> addCountryToFavorites(
          _i6.Country? country) =>
      (super.noSuchMethod(Invocation.method(#addCountryToFavorites, [country]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> removeCountryFromFavorites(
          _i6.Country? country) =>
      (super.noSuchMethod(
              Invocation.method(#removeCountryFromFavorites, [country]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
