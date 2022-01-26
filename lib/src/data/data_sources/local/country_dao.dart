import 'package:covid_app/src/core/constant.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:floor/floor.dart';

@dao
abstract class CountryDao{
  @Query("SELECT * FROM $kCountryTableName")
  Future<List<Country>> findALlCountries();

  @Query("SELECT * FROM $kCountryTableName")
  Stream<List<Country>> findALlCountriesStream();

  @Query("SELECT country FROM $kCountryTableName")
  Future<List<String>?> findAllCountriesNames();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCountry(Country country);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCountry(Country country);

  @delete
  Future<void> deleteCountry(Country country);
}