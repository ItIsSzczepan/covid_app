// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CountryDao? _countryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Country` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `country` TEXT NOT NULL, `countryCode` TEXT NOT NULL, `flag` TEXT NOT NULL, `cases` INTEGER NOT NULL, `todayCases` INTEGER NOT NULL, `todayDeaths` INTEGER NOT NULL, `deaths` INTEGER NOT NULL, `todayRecovered` INTEGER NOT NULL, `recovered` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CountryDao get countryDao {
    return _countryDaoInstance ??= _$CountryDao(database, changeListener);
  }
}

class _$CountryDao extends CountryDao {
  _$CountryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _countryInsertionAdapter = InsertionAdapter(
            database,
            'Country',
            (Country item) => <String, Object?>{
                  'id': item.id,
                  'country': item.country,
                  'countryCode': item.countryCode,
                  'flag': item.flag,
                  'cases': item.cases,
                  'todayCases': item.todayCases,
                  'todayDeaths': item.todayDeaths,
                  'deaths': item.deaths,
                  'todayRecovered': item.todayRecovered,
                  'recovered': item.recovered
                }),
        _countryUpdateAdapter = UpdateAdapter(
            database,
            'Country',
            ['id'],
            (Country item) => <String, Object?>{
                  'id': item.id,
                  'country': item.country,
                  'countryCode': item.countryCode,
                  'flag': item.flag,
                  'cases': item.cases,
                  'todayCases': item.todayCases,
                  'todayDeaths': item.todayDeaths,
                  'deaths': item.deaths,
                  'todayRecovered': item.todayRecovered,
                  'recovered': item.recovered
                }),
        _countryDeletionAdapter = DeletionAdapter(
            database,
            'Country',
            ['id'],
            (Country item) => <String, Object?>{
                  'id': item.id,
                  'country': item.country,
                  'countryCode': item.countryCode,
                  'flag': item.flag,
                  'cases': item.cases,
                  'todayCases': item.todayCases,
                  'todayDeaths': item.todayDeaths,
                  'deaths': item.deaths,
                  'todayRecovered': item.todayRecovered,
                  'recovered': item.recovered
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Country> _countryInsertionAdapter;

  final UpdateAdapter<Country> _countryUpdateAdapter;

  final DeletionAdapter<Country> _countryDeletionAdapter;

  @override
  Future<List<Country>> findALlCountries() async {
    return _queryAdapter.queryList('SELECT * FROM FavoritesCountries',
        mapper: (Map<String, Object?> row) => Country(
            country: row['country'] as String,
            countryCode: row['countryCode'] as String,
            flag: row['flag'] as String,
            todayCases: row['todayCases'] as int,
            cases: row['cases'] as int,
            todayDeaths: row['todayDeaths'] as int,
            deaths: row['deaths'] as int,
            todayRecovered: row['todayRecovered'] as int,
            recovered: row['recovered'] as int,
            id: row['id'] as int?));
  }

  @override
  Future<List<String>?> findAllCountriesNames() async {
    await _queryAdapter.queryNoReturn('SELECT country FROM FavoritesCountries');
  }

  @override
  Future<void> insertCountry(Country country) async {
    await _countryInsertionAdapter.insert(country, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateCountry(Country country) async {
    await _countryUpdateAdapter.update(country, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteCountry(Country country) async {
    await _countryDeletionAdapter.delete(country);
  }
}
