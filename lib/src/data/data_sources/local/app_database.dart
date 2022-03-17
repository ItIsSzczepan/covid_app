import 'package:covid_app/src/core/constant.dart';
import 'package:covid_app/src/data/data_sources/local/country_dao.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 3, entities: [Country])
abstract class AppDatabase extends FloorDatabase{
  CountryDao get countryDao;
}

final migration1to2 = Migration(1, 2, (db) async{
  await db.execute("ALTER TABLE Country RENAME TO $kCountryTableName");
  await db.execute("ALTER TABLE $kCountryTableName ADD COLUMN updated INT NOT NULL");
  await db.execute("UPDATE $kCountryTableName SET updated=${DateTime.now().millisecondsSinceEpoch~/1000}");
});

final migration2to3 = Migration(2, 3, (db)async{
  await db.execute("UPDATE $kCountryTableName SET updated=${DateTime.now().millisecondsSinceEpoch~/1000}");
});