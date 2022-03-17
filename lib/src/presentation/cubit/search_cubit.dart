import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super("");

  void edit(String text) => emit(text);
  void clear() => emit("");
}
