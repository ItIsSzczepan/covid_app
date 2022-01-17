import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/add_country_to_favorites_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_favorites_countries_usecase.dart';
import 'package:covid_app/src/domain/use_cases/remove_country_from_favorites_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCountriesCubit extends Cubit<Stream<List<Country>>> {
  final GetFavoritesCountriesUseCase _getFavoritesCountriesUseCase;
  final AddCountryToFavoritesUseCase _addCountryToFavoritesUseCase;
  final RemoveCountryFromFavoritesUseCase _removeCountryFromFavoritesUseCase;

  FavoritesCountriesCubit(this._getFavoritesCountriesUseCase,
      this._addCountryToFavoritesUseCase, this._removeCountryFromFavoritesUseCase)
      : super(const Stream.empty()) {
    _init();
  }

  _init() async {
    final result = await _getFavoritesCountriesUseCase();
    result.fold((l) => emit(Stream.error(l.message)), (r) => emit(r));
  }

  addCountryToFavorites(Country country, Function(Failure error) onError) {
    _addCountryToFavoritesUseCase(params: country).then((value) {
      value.fold((error) => onError(error), (result) => {});
    });
  }
  removeCountryFromFavorites(Country country, Function(Failure error) onError) {
    _removeCountryFromFavoritesUseCase(params: country).then((value) {
      value.fold((error) => onError(error), (result) => {});
    });
  }
}
