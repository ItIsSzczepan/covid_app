part of 'global_data_cubit.dart';

abstract class GlobalDataState extends Equatable {
  const GlobalDataState();
}

class GlobalDataInitial extends GlobalDataState {
  @override
  List<Object> get props => [];
}

class GlobalDataLoading extends GlobalDataState{
  @override
  List<Object?> get props => [];
}

class GlobalDataDone extends GlobalDataState{
  final Record data;

  const GlobalDataDone({required this.data});

  @override
  List<Object?> get props => [data];
}

class GlobalDataError extends GlobalDataState{
  final String message;

  const GlobalDataError(this.message);

  @override
  List<Object?> get props => [message];
}
