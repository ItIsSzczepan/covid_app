import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:covid_app/src/domain/use_cases/get_favorites_countries_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../models.dart';
import 'get_favorites_countries_usecase_test.mocks.dart';

@GenerateMocks([CovidRepository])
void main() {
  late GetFavoritesCountriesUseCase useCase;
  late CovidRepository fakeCovidRepository;

  setUp(() {
    fakeCovidRepository = MockCovidRepository();
    useCase = GetFavoritesCountriesUseCase(fakeCovidRepository);
  });

  final List<Country> exampleList = TestModels().exampleList;

  final Failure exampleFailure = TestModels().exampleFailure;

  test("should get countries data list", () async {
    when(fakeCovidRepository.getAllFavoritesCountries())
        .thenAnswer((_) async => Right(Stream.value(exampleList)));

    final result = await useCase();

    expect(await result.getOrElse(() => const Stream.empty()).first, exampleList);
    verify(fakeCovidRepository.getAllFavoritesCountries());
    verifyNoMoreInteractions(fakeCovidRepository);
  });

  test("should get error", () async {
    when(fakeCovidRepository.getAllFavoritesCountries())
        .thenAnswer((_) async => Left(exampleFailure));

    final result = await useCase();

    expect(result, Left(exampleFailure));
    verify(fakeCovidRepository.getAllFavoritesCountries());
    verifyNoMoreInteractions(fakeCovidRepository);
  });
}
