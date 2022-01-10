import 'package:bloc/bloc.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/get_summary_usecase.dart';
import 'package:equatable/equatable.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  final GetSummaryUseCase _getSummaryUseCase;
  int _selected = 0;

  SummaryCubit(this._getSummaryUseCase) : super(SummaryInitial());

  refresh() async {
    emit(SummaryLoading());
    _getSummaryUseCase.call().then((value) => value.fold(
        (l) => emit(SummaryError(l.message)),
        (r) => emit(SummaryDone(countries: r, selectedCountry: _selected))));
  }

  selectCountry(int index) {
    _selected = index;
    emit((state as SummaryDone).copyWith(index));
  }
}
