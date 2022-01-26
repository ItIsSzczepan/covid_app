// Mocks generated by Mockito 5.0.17 from annotations
// in covid_app/test/presentation/pages/global_data_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:bloc/bloc.dart' as _i9;
import 'package:covid_app/src/core/failure.dart' as _i6;
import 'package:covid_app/src/core/params.dart' as _i8;
import 'package:covid_app/src/domain/entities/record.dart' as _i7;
import 'package:covid_app/src/domain/use_cases/get_global_data_usecase.dart'
    as _i4;
import 'package:covid_app/src/presentation/cubit/global_data_cubit.dart' as _i3;
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

class _FakeGlobalDataState_1 extends _i1.Fake implements _i3.GlobalDataState {}

/// A class which mocks [GetGlobalDataUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetGlobalDataUseCase extends _i1.Mock
    implements _i4.GetGlobalDataUseCase {
  MockGetGlobalDataUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, _i7.Record>> call({_i8.Params? params}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#params: params}),
              returnValue: Future<_i2.Either<_i6.Failure, _i7.Record>>.value(
                  _FakeEither_0<_i6.Failure, _i7.Record>()))
          as _i5.Future<_i2.Either<_i6.Failure, _i7.Record>>);
}

/// A class which mocks [GlobalDataCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockGlobalDataCubit extends _i1.Mock implements _i3.GlobalDataCubit {
  MockGlobalDataCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.GlobalDataState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeGlobalDataState_1()) as _i3.GlobalDataState);
  @override
  _i5.Stream<_i3.GlobalDataState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.GlobalDataState>.empty())
          as _i5.Stream<_i3.GlobalDataState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void emit(_i3.GlobalDataState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i9.Change<_i3.GlobalDataState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}
