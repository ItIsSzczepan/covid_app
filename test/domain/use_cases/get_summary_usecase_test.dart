import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:covid_app/src/domain/use_cases/get_summary_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_summary_usecase_test.mocks.dart';

@GenerateMocks([CovidRepository])
void main() {
  late GetSummaryUseCase useCase;
  late CovidRepository fakeCovidRepository;

  setUp(() {
    fakeCovidRepository = MockCovidRepository();
    useCase = GetSummaryUseCase(fakeCovidRepository);
  });

  final List<Country> exampleList = [
    const Country(
        country: "Poland",
        countryCode: "PL",
        slug: "poland",
        record: Record(
            newConfirmed: 3,
            totalConfirmed: 10,
            newDeaths: 1,
            totalDeaths: 2,
            newRecovered: 2,
            totalRecovered: 3)),
    const Country(
        country: "Germany",
        countryCode: "DE",
        slug: "germany",
        record: Record(
            newConfirmed: 30,
            totalConfirmed: 100,
            newDeaths: 10,
            totalDeaths: 20,
            newRecovered: 20,
            totalRecovered: 30))
  ];

  final Failure exampleFailure = Failure("message");

  test("should get countries summary list", () async {
    when(fakeCovidRepository.getSummary())
        .thenAnswer((_) async => Right(exampleList));

    final result = await useCase();

    expect(result, Right(exampleList));
    verify(fakeCovidRepository.getSummary());
    verifyNoMoreInteractions(fakeCovidRepository);
  });

  test("should get error", () async {
    when(fakeCovidRepository.getSummary())
        .thenAnswer((_) async => Left(exampleFailure));

    final result = await useCase();

    expect(result, Left(exampleFailure));
    verify(fakeCovidRepository.getSummary());
    verifyNoMoreInteractions(fakeCovidRepository);
  });
}
