import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/domain/entities/country.dart';

class GetSummaryResponse {
  final List<Country> countries;

  GetSummaryResponse(
      {required this.countries});

  factory GetSummaryResponse.fromJson(Map<String, dynamic> json) {
    List<Country> list = [];
    json['Global']['country'] = "Global";
    json['Global']['countryCode'] = "GL";
    json['Global']['slug'] = "global";
    list.add(CountryModel.fromJson(json['Global']));

    (json['Countries'] as List).forEach((element) {
      list.add(CountryModel.fromJson(element));
    });

    return GetSummaryResponse(
      countries: list
    );
  }
}
