import 'package:bloc/bloc.dart';
import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/domain/use_cases/get_global_data_usecase.dart';
import 'package:equatable/equatable.dart';

part 'global_data_state.dart';

class GlobalDataCubit extends Cubit<GlobalDataState> {
  final GetGlobalDataUseCase _getGlobalDataUseCase;

  GlobalDataCubit(this._getGlobalDataUseCase) : super(GlobalDataInitial());

  load() async {
    emit(GlobalDataLoading());
    _getGlobalDataUseCase.call().then((value) => value.fold(
        (l) => emit(GlobalDataError(l.message)),
        (r) => emit(GlobalDataDone(data: r))));
  }
}
