import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/domain/entities/country.dart';

class GetAllCountriesListResponse {
  final List<Country> countries;

  GetAllCountriesListResponse({required this.countries});

  factory GetAllCountriesListResponse.fromJson(List<dynamic> json) {
    print(json);
    return GetAllCountriesListResponse(
        countries: List<Country>.from(json.map(
            (e) {print(e); return CountryModel.fromJson(e as Map<String, dynamic>);}).toList()));
  }
}
