import 'package:covid_app/src/core/constant.dart';
import 'package:covid_app/src/data/data_sources/local/app_database.dart';
import 'package:covid_app/src/data/data_sources/remote/covid_api_service.dart';
import 'package:covid_app/src/data/repositories/covid_repository_impl.dart';
import 'package:covid_app/src/domain/use_cases/add_country_to_favorites_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_favorites_countries_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_global_data_usecase.dart';
import 'package:covid_app/src/domain/use_cases/remove_country_from_favorites_usecase.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:covid_app/src/presentation/cubit/global_data_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'domain/repositories/covid_repository.dart';

final injector = GetIt.instance;

initializeDependencies()async{
  final database = await $FloorAppDatabase.databaseBuilder(kDatabaseName).addMigrations([migration1to2, migration2to3]).build();

  injector.registerSingleton<AppDatabase>(database);
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<CovidApiService>(CovidApiService(injector()));
  injector.registerSingleton<CovidRepository>(CovidRepositoryImpl(injector(), injector()));

  injector.registerSingleton<GetAllCountriesListDataUseCase>(GetAllCountriesListDataUseCase(injector()));
  injector.registerSingleton<GetGlobalDataUseCase>(GetGlobalDataUseCase(injector()));
  injector.registerSingleton<GetFavoritesCountriesUseCase>(GetFavoritesCountriesUseCase(injector()));
  injector.registerSingleton<AddCountryToFavoritesUseCase>(AddCountryToFavoritesUseCase(injector()));
  injector.registerSingleton<RemoveCountryFromFavoritesUseCase>(RemoveCountryFromFavoritesUseCase(injector()));

  injector.registerFactory<CountriesListCubit>(() => CountriesListCubit(injector()));
  injector.registerFactory<FavoritesCountriesCubit>(() => FavoritesCountriesCubit(injector(), injector(), injector()));
  injector.registerFactory<GlobalDataCubit>(() => GlobalDataCubit(injector()));
}