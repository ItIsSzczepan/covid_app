part of 'countries_list_cubit.dart';

abstract class CountriesListState extends Equatable {
  const CountriesListState();
}

class CountriesListInitial extends CountriesListState {
  @override
  List<Object> get props => [];
}

class CountriesListLoading extends CountriesListState{
  @override
  List<Object?> get props => [];
}

class CountriesListDone extends CountriesListState{
  final List<Country> countries;
  final int selectedCountry;

  const CountriesListDone({required this.countries, required this.selectedCountry});

  @override
  List<Object?> get props => [countries, selectedCountry];

  CountriesListDone copyWith(int selectedCountry){
    return CountriesListDone(
        countries: countries,
        selectedCountry: selectedCountry);
  }
}

class CountriesListError extends CountriesListState{
  final String message;

  const CountriesListError(this.message);

  @override
  List<Object?> get props => [message];
}
