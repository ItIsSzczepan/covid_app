import 'package:bloc_test/bloc_test.dart';
import 'package:covid_app/src/domain/use_cases/get_global_data_usecase.dart';
import 'package:covid_app/src/presentation/cubit/global_data_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../models.dart';
import 'global_data_cubit_test.mocks.dart';

@GenerateMocks([GetGlobalDataUseCase])
void main(){
  late GlobalDataCubit cubit;
  late GetGlobalDataUseCase useCase;

  setUp((){
    useCase = MockGetGlobalDataUseCase();
    cubit = GlobalDataCubit(useCase);
  });

  blocTest<GlobalDataCubit, GlobalDataState>(
    'cubit return list',
    build: () => cubit,
    setUp: (){
      when(useCase.call()).thenAnswer((_) async => Right(TestModels().exampleRecord));
    },
    act: (bloc) {
      bloc.load();
    },
    expect: () => <GlobalDataState>[
      GlobalDataLoading(),
      GlobalDataDone(data: TestModels().exampleRecord)
    ],
  );

  blocTest<GlobalDataCubit, GlobalDataState>(
    'cubit return error',
    build: () => cubit,
    setUp: (){
      when(useCase.call()).thenAnswer((_) async => Left(TestModels().exampleFailure));
    },
    act: (bloc) {
      bloc.load();
    },
    expect: () => <GlobalDataState>[
      GlobalDataLoading(),
      GlobalDataError(TestModels().exampleFailure.message)
    ],
  );

}