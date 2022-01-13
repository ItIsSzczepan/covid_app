import 'package:bloc/bloc.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_global_data_usecase.dart';
import 'package:equatable/equatable.dart';

part 'global_data_state.dart';

class GlobalDataCubit extends Cubit<GlobalDataState> {
  final GetGlobalDataUseCase _getSummaryUseCase;

  GlobalDataCubit(this._getSummaryUseCase) : super(GlobalDataInitial());

  load() async {
    emit(GlobalDataLoading());
    _getSummaryUseCase.call().then((value) => value.fold(
        (l) => emit(GlobalDataError(l.message)),
        (r) => emit(GlobalDataDone(data: r))));
  }
}
