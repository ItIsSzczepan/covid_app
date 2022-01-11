import 'package:bloc/bloc.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:equatable/equatable.dart';

part 'countries_list_state.dart';

class CountriesListCubit extends Cubit<CountriesListState> {
  final GetAllCountriesListDataUseCase _getSummaryUseCase;
  int _selected = 0;

  CountriesListCubit(this._getSummaryUseCase) : super(CountriesListInitial());

  refresh() async {
    emit(CountriesListLoading());
    _getSummaryUseCase.call().then((value) => value.fold(
        (l) => emit(CountriesListError(l.message)),
        (r) => emit(CountriesListDone(countries: r, selectedCountry: _selected))));
  }

  selectCountry(int index) {
    _selected = index;
    emit((state as CountriesListDone).copyWith(index));
  }
}
