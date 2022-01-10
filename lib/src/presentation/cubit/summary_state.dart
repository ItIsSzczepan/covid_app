part of 'summary_cubit.dart';

abstract class SummaryState extends Equatable {
  const SummaryState();
}

class SummaryInitial extends SummaryState {
  @override
  List<Object> get props => [];
}

class SummaryLoading extends SummaryState{
  @override
  List<Object?> get props => [];
}

class SummaryDone extends SummaryState{
  final List<Country> countries;
  final int selectedCountry;

  const SummaryDone({required this.countries, required this.selectedCountry});

  @override
  List<Object?> get props => [countries, selectedCountry];

  SummaryDone copyWith(int selectedCountry){
    return SummaryDone(
        countries: countries,
        selectedCountry: selectedCountry);
  }
}

class SummaryError extends SummaryState{
  final String message;

  const SummaryError(this.message);

  @override
  List<Object?> get props => [message];
}
