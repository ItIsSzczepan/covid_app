import 'package:covid_app/src/domain/entities/country.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel extends Country {
  const CountryModel({country, countryCode, slug, record})
      : super(
            country: country,
            countryCode: countryCode,
            slug: slug,
            record: record);

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);
}
