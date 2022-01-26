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

  const CountriesListDone({required this.countries});

  @override
  List<Object?> get props => [countries];
}

class CountriesListError extends CountriesListState{
  final String message;

  const CountriesListError(this.message);

  @override
  List<Object?> get props => [message];
}
