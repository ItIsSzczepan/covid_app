import 'package:covid_app/src/domain/entities/record.dart';
import 'package:equatable/equatable.dart';

class Country extends Equatable{
  final String country;
  final String countryCode;
  final String slug;
  final Record record;

  const Country({required this.country, required this.countryCode, required this.slug, required this.record});

  @override
  List<Object?> get props => [country, countryCode, slug, record];
}