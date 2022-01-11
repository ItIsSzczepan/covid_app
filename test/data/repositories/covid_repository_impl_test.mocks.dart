// Mocks generated by Mockito 5.0.17 from annotations
// in covid_app/test/data/repositories/covid_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart'
    as _i3;
import 'package:covid_app/src/data/models/country_model.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:retrofit/dio.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeHttpResponse_0<T> extends _i1.Fake implements _i2.HttpResponse<T> {}

/// A class which mocks [CovidApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCovidApiService extends _i1.Mock implements _i3.CovidApiService {
  MockCovidApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.HttpResponse<List<_i5.CountryModel>>> getAllCountriesList() =>
      (super.noSuchMethod(Invocation.method(#getAllCountriesList, []),
          returnValue: Future<_i2.HttpResponse<List<_i5.CountryModel>>>.value(
              _FakeHttpResponse_0<List<_i5.CountryModel>>())) as _i4
          .Future<_i2.HttpResponse<List<_i5.CountryModel>>>);
}
