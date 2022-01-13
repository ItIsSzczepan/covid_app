import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/repositories/covid_repository.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_global_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_global_data_usecase_test.mocks.dart';

@GenerateMocks([CovidRepository])
void main() {
  late GetGlobalDataUseCase useCase;
  late CovidRepository fakeCovidRepository;

  setUp(() {
    fakeCovidRepository = MockCovidRepository();
    useCase = GetGlobalDataUseCase(fakeCovidRepository);
  });

  Record exampleRecord = const Record(
      cases: 3,
      todayCases: 10,
      todayDeaths: 1,
      deaths: 2,
      todayRecovered: 2,
      recovered: 3);

  final Failure exampleFailure = Failure("message");

  test("should get countries data list", () async {
    when(fakeCovidRepository.getGlobal())
        .thenAnswer((_) async => Right(exampleRecord));

    final result = await useCase();

    expect(result, Right(exampleRecord));
    verify(fakeCovidRepository.getGlobal());
    verifyNoMoreInteractions(fakeCovidRepository);
  });

  test("should get error", () async {
    when(fakeCovidRepository.getGlobal())
        .thenAnswer((_) async => Left(exampleFailure));

    final result = await useCase();

    expect(result, Left(exampleFailure));
    verify(fakeCovidRepository.getGlobal());
    verifyNoMoreInteractions(fakeCovidRepository);
  });
}
