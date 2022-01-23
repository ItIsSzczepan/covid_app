import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_countries_list_data_usecase_test.mocks.dart';

@GenerateMocks([CovidRepository])
void main() {
  late GetAllCountriesListDataUseCase useCase;
  late CovidRepository fakeCovidRepository;

  setUp(() {
    fakeCovidRepository = MockCovidRepository();
    useCase = GetAllCountriesListDataUseCase(fakeCovidRepository);
  });

  final List<Country> exampleList = [
    const Country(
        country: "Poland",
        countryCode: "PL",
        flag: "poland",
            cases: 3,
            todayCases: 10,
            todayDeaths: 1,
            deaths: 2,
            todayRecovered: 2,
            recovered: 3),
    const Country(
        country: "Germany",
        countryCode: "DE",
        flag: "germany",
            cases: 30,
            todayCases: 100,
            todayDeaths: 10,
            deaths: 20,
            todayRecovered: 20,
            recovered: 30)
  ];

  final Failure exampleFailure = Failure("message");

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
