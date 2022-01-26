import 'package:bloc/bloc.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:equatable/equatable.dart';

part 'countries_list_state.dart';

class CountriesListCubit extends Cubit<CountriesListState> {
  final GetAllCountriesListDataUseCase _getAllCountriesListDataUseCase;

  CountriesListCubit(this._getAllCountriesListDataUseCase) : super(CountriesListInitial());

  load() async {
    emit(CountriesListLoading());
    _getAllCountriesListDataUseCase.call().then((value) => value.fold(
        (l) => emit(CountriesListError(l.message)),
        (r) => emit(CountriesListDone(countries: r))));
  }
}
