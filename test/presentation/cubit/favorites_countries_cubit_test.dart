import 'package:bloc_test/bloc_test.dart';
import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/add_country_to_favorites_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_favorites_countries_usecase.dart';
import 'package:covid_app/src/domain/use_cases/remove_country_from_favorites_usecase.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../models.dart';
import 'favorites_countries_cubit_test.mocks.dart';

class FakeError {
  onError(Failure failure) {}
}

@GenerateMocks([
  GetFavoritesCountriesUseCase,
  AddCountryToFavoritesUseCase,
  RemoveCountryFromFavoritesUseCase,
  FakeError
])
void main() {
  late final GetFavoritesCountriesUseCase _getFavoritesCountriesUseCase;
  late final AddCountryToFavoritesUseCase _addCountryToFavoritesUseCase;
  late final RemoveCountryFromFavoritesUseCase
      _removeCountryFromFavoritesUseCase;
  late final FavoritesCountriesCubit _favoritesCountriesCubit;
  late Stream<List<Country>> _stream;
  late final FakeError _fakeError;

  final List<Country> exampleList = TestModels().exampleList;

  final Failure exampleFailure = TestModels().exampleFailure;

  flutter_test.setUpAll(() {
    _stream = Stream<List<Country>>.value(exampleList);

    // mock UseCases
    _getFavoritesCountriesUseCase = MockGetFavoritesCountriesUseCase();
    _addCountryToFavoritesUseCase = MockAddCountryToFavoritesUseCase();
    _removeCountryFromFavoritesUseCase =
        MockRemoveCountryFromFavoritesUseCase();
    _fakeError = MockFakeError();

    when(_fakeError.onError(exampleFailure)).thenReturn(null);
    when(_getFavoritesCountriesUseCase())
        .thenAnswer((realInvocation) async => Right(_stream));

    _favoritesCountriesCubit = FavoritesCountriesCubit(
        _getFavoritesCountriesUseCase,
        _addCountryToFavoritesUseCase,
        _removeCountryFromFavoritesUseCase);
  });

  blocTest("cubit return Stream at init",
      build: () {
        when(_getFavoritesCountriesUseCase())
            .thenAnswer((realInvocation) async => Right(_stream));
        return FavoritesCountriesCubit(_getFavoritesCountriesUseCase,
            _addCountryToFavoritesUseCase, _removeCountryFromFavoritesUseCase);
      },
      expect: () => [_stream],
      verify: (cubit) {
        verify(_getFavoritesCountriesUseCase());
        verifyNoMoreInteractions(_getFavoritesCountriesUseCase);
      });

  blocTest<FavoritesCountriesCubit, Stream>("add function should return error",
      setUp: () {
        when(_addCountryToFavoritesUseCase(params: exampleList[0]))
            .thenAnswer((realInvocation) async => Left(exampleFailure));
      },
      build: () {
        return _favoritesCountriesCubit;
      },
      act: (cubit) =>
          cubit.addCountryToFavorites(exampleList[0], _fakeError.onError),
      expect: () => [],
      verify: (cubit) {
        verify(_addCountryToFavoritesUseCase(params: exampleList[0]));
        verify(_fakeError.onError(exampleFailure));
      });

  blocTest<FavoritesCountriesCubit, Stream>(
      "remove function should return error",
      setUp: () {
        when(_removeCountryFromFavoritesUseCase(params: exampleList[0]))
            .thenAnswer((realInvocation) async => Left(exampleFailure));
      },
      build: () => _favoritesCountriesCubit,
      act: (cubit) =>
          cubit.removeCountryFromFavorites(exampleList[0], _fakeError.onError),
      expect: () => [],
      verify: (cubit) {
        verify(_removeCountryFromFavoritesUseCase(params: exampleList[0]));
        verify(_fakeError.onError(exampleFailure));
      });
}
