import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../models.dart';
import 'get_countries_list_data_usecase_test.mocks.dart';

@GenerateMocks([CovidRepository])
void main() {
  late GetAllCountriesListDataUseCase useCase;
  late CovidRepository fakeCovidRepository;

  setUp(() {
    fakeCovidRepository = MockCovidRepository();
    useCase = GetAllCountriesListDataUseCase(fakeCovidRepository);
  });

  final List<Country> exampleList = TestModels().exampleList;

  final Failure exampleFailure = TestModels().exampleFailure;

  test("should get countries data list", () async {
    when(fakeCovidRepository.getAllCountriesListData())
        .thenAnswer((_) async => Right(exampleList));

    final result = await useCase();

    expect(result, Right(exampleList));
    verify(fakeCovidRepository.getAllCountriesListData());
    verifyNoMoreInteractions(fakeCovidRepository);
  });

  test("should get error", () async {
    when(fakeCovidRepository.getAllCountriesListData())
        .thenAnswer((_) async => Left(exampleFailure));

    final result = await useCase();

    expect(result, Left(exampleFailure));
    verify(fakeCovidRepository.getAllCountriesListData());
    verifyNoMoreInteractions(fakeCovidRepository);
  });
}
