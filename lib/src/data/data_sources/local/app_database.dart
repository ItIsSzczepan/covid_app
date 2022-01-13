import 'package:covid_app/src/data/data_sources/local/country_dao.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Country])
abstract class AppDatabase extends FloorDatabase{
  CountryDao get countryDao;
}