import 'package:bloc_test/bloc_test.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../models.dart';
import 'countries_list_cubit_test.mocks.dart';

@GenerateMocks([GetAllCountriesListDataUseCase])
void main() {
  late CountriesListCubit cubit;
  late GetAllCountriesListDataUseCase useCase;

  setUp(() {
    useCase = MockGetAllCountriesListDataUseCase();
    cubit = CountriesListCubit(useCase);
  });

  blocTest<CountriesListCubit, CountriesListState>(
    'cubit return list',
    build: () => cubit,
    setUp: () {
      when(useCase.call())
          .thenAnswer((_) async => Right(TestModels().exampleList));
    },
    act: (bloc) {
      bloc.load();
    },
    expect: () => <CountriesListState>[
      CountriesListLoading(),
      CountriesListDone(countries: TestModels().exampleList)
    ],
  );

  blocTest<CountriesListCubit, CountriesListState>(
    'cubit return error',
    build: () => cubit,
    setUp: () {
      when(useCase.call())
          .thenAnswer((_) async => Left(TestModels().exampleFailure));
    },
    act: (bloc) {
      bloc.load();
    },
    expect: () => <CountriesListState>[
      CountriesListLoading(),
      CountriesListError(TestModels().exampleFailure.message)
    ],
  );
}
