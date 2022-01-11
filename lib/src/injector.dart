import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/data/repositories/covid_repository_impl.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'domain/repositories/covid_repository.dart';

final injector = GetIt.instance;

initializeDependencies(){
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<CovidApiService>(CovidApiService(injector()));
  injector.registerSingleton<CovidRepository>(CovidRepositoryImpl(injector()));

  injector.registerSingleton<GetAllCountriesListDataUseCase>(GetAllCountriesListDataUseCase(injector()));

  injector.registerFactory<CountriesListCubit>(() => CountriesListCubit(injector()));
}