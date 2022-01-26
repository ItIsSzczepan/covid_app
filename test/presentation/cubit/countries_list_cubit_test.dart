import 'package:bloc_test/bloc_test.dart';
import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'countries_list_cubit_test.mocks.dart';

@GenerateMocks([GetAllCountriesListDataUseCase])
void main(){
  late CountriesListCubit cubit;
  late GetAllCountriesListDataUseCase useCase;

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

  setUp((){
    useCase = MockGetAllCountriesListDataUseCase();
    cubit = CountriesListCubit(useCase);
  });

  blocTest<CountriesListCubit, CountriesListState>(
    'cubit return list',
    build: () => cubit,
    setUp: (){
      when(useCase.call()).thenAnswer((_) async => Right(exampleList));
    },
    act: (bloc) {
      bloc.load();
    },
    expect: () => <CountriesListState>[
      CountriesListLoading(),
      CountriesListDone(countries: exampleList)
    ],
  );

  blocTest<CountriesListCubit, CountriesListState>(
    'cubit return error',
    build: () => cubit,
    setUp: (){
      when(useCase.call()).thenAnswer((_) async => Left(exampleFailure));
    },
    act: (bloc) {
      bloc.load();
    },
    expect: () => <CountriesListState>[
      CountriesListLoading(),
      CountriesListError(exampleFailure.message)
    ],
  );

}