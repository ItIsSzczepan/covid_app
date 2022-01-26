import 'dart:async';

import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/add_country_to_favorites_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_all_countries_list_data_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_favorites_countries_usecase.dart';
import 'package:covid_app/src/domain/use_cases/remove_country_from_favorites_usecase.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:covid_app/src/presentation/pages/countries_list_page.dart';
import 'package:covid_app/src/presentation/widgets/country_tile.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../models.dart';
import 'countries_list_page_test.mocks.dart';

@GenerateMocks([
  GetAllCountriesListDataUseCase,
  GetFavoritesCountriesUseCase,
  AddCountryToFavoritesUseCase,
  RemoveCountryFromFavoritesUseCase
])
void main() {
  late final GetAllCountriesListDataUseCase getAllCountriesListDataUseCase;
  late final GetFavoritesCountriesUseCase getFavoritesCountriesUseCase;
  late final AddCountryToFavoritesUseCase addCountryToFavoritesUseCase;
  late final RemoveCountryFromFavoritesUseCase
      removeCountryFromFavoritesUseCase;
  late CountriesListCubit apiCubit;
  late FavoritesCountriesCubit favoritesCubit;
  late Widget testPage;

  setUpAll(() {
    getAllCountriesListDataUseCase = MockGetAllCountriesListDataUseCase();
    getFavoritesCountriesUseCase = MockGetFavoritesCountriesUseCase();
    addCountryToFavoritesUseCase = MockAddCountryToFavoritesUseCase();
    removeCountryFromFavoritesUseCase = MockRemoveCountryFromFavoritesUseCase();
  });

  setUp(() {
    // test Stream
    StreamController<List<Country>> _streamController =
        StreamController<List<Country>>();
    Stream<List<Country>> _stream = _streamController.stream;

    // return stream
    when(getFavoritesCountriesUseCase.call())
        .thenAnswer((realInvocation) async => Right(_stream));
    // add value to stream
    when(addCountryToFavoritesUseCase.call(
            params: TestModels().exampleList.first))
        .thenAnswer((realInvocation) async {
      _streamController.add([TestModels().exampleList.first]);
      return const Right(null);
    });
    // remove value from stream
    when(removeCountryFromFavoritesUseCase.call(
            params: TestModels().exampleList.first))
        .thenAnswer((realInvocation) async {
      _streamController.add([]);
      return const Right(null);
    });

    apiCubit = CountriesListCubit(getAllCountriesListDataUseCase);
    favoritesCubit = FavoritesCountriesCubit(getFavoritesCountriesUseCase,
        addCountryToFavoritesUseCase, removeCountryFromFavoritesUseCase);

    testPage = MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider<CountriesListCubit>(create: (_) => apiCubit..load()),
        BlocProvider<FavoritesCountriesCubit>(create: (_) => favoritesCubit),
      ], child: const CountriesListPage()),
    );
  });

  _buildWidget(WidgetTester tester) async {
    when(getAllCountriesListDataUseCase.call())
        .thenAnswer((realInvocation) async => Right(TestModels().exampleList));
    await tester.pumpWidget(testPage);
    await tester.pump(const Duration(milliseconds: 200));
  }

  testWidgets("widget should display placeholders",
      (WidgetTester tester) async {
    when(getAllCountriesListDataUseCase.call())
        .thenAnswer((realInvocation) async => Right(TestModels().exampleList));
    await tester.pumpWidget(testPage);

    final findPlaceholders = find.byType(PlaceholderLines);

    expect(findPlaceholders, findsWidgets);
  });
  group("Loading data", () {
    testWidgets("widget should display list of CountryTiles",
        (WidgetTester tester) async {
      await _buildWidget(tester);

      final findCountriesTiles = find.byType(CountryTile);
      final findCountryTileWithData = find.widgetWithText(
          CountryTile, TestModels().exampleList.first.country);

      expect(findCountriesTiles, findsWidgets);
      expect(findCountryTileWithData, findsOneWidget);
    });

    testWidgets("widget should display CountryTile with all data",
        (WidgetTester tester) async {
      await _buildWidget(tester);

      final List<Finder> countryTileDataFinders = [
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.country),
        find.widgetWithText(CountryTile,
            "Cases\n${TestModels().exampleList.first.todayCases.toString()}\n${TestModels().exampleList.first.cases.toString()}"),
        find.widgetWithText(CountryTile,
            "Deaths\n${TestModels().exampleList.first.todayDeaths.toString()}\n${TestModels().exampleList.first.deaths.toString()}"),
        find.widgetWithText(CountryTile,
            "Recovered\n${TestModels().exampleList.first.todayRecovered.toString()}\n${TestModels().exampleList.first.recovered.toString()}"),
      ];

      for (var value in countryTileDataFinders) {
        expect(value, findsOneWidget);
      }
    });

    testWidgets(
        "widget should display change favorite icon in CountryTile after click on it",
        (WidgetTester tester) async {
      await _buildWidget(tester);

      final findCountryTileFavoriteButton = find.byIcon(Icons.favorite_outline);
      expect(findCountryTileFavoriteButton, findsWidgets);

      await tester.tap(findCountryTileFavoriteButton.first);
      await tester.pump();
      verify(addCountryToFavoritesUseCase.call(
          params: TestModels().exampleList.first));

      final findCountryTileAddedToFavorites =
          find.widgetWithIcon(CountryTile, Icons.favorite);
      expect(findCountryTileAddedToFavorites, findsOneWidget);
    });

    testWidgets("widget should display error click on it",
        (WidgetTester tester) async {
      when(addCountryToFavoritesUseCase.call(
              params: TestModels().exampleList.first))
          .thenAnswer(
              (realInvocation) async => Left(TestModels().exampleFailure));
      await _buildWidget(tester);

      final findCountryTileFavoriteButton = find.byIcon(Icons.favorite_outline);
      expect(findCountryTileFavoriteButton, findsWidgets);

      await tester.tap(findCountryTileFavoriteButton.first);
      await tester.pump();

      verify(addCountryToFavoritesUseCase.call(
          params: TestModels().exampleList.first));

      final findSnackBarWithError =
          find.widgetWithText(SnackBar, TestModels().exampleFailure.message);
      expect(findSnackBarWithError, findsOneWidget);

      final findCountryTileAddedToFavorites =
          find.widgetWithIcon(CountryTile, Icons.favorite);
      expect(findCountryTileAddedToFavorites, findsNothing);
    });

    testWidgets("widget should change back favorite icon after second tap",
        (WidgetTester tester) async {
      await _buildWidget(tester);

      final findCountryTileFavoriteButton = find.byIcon(Icons.favorite_outline);
      expect(findCountryTileFavoriteButton, findsWidgets);

      await tester.tap(findCountryTileFavoriteButton.first);
      await tester.pump();

      final findCountryTileAddedToFavorites = find.byIcon(Icons.favorite);
      expect(findCountryTileAddedToFavorites, findsOneWidget);

      await tester.tap(findCountryTileAddedToFavorites.first);
      await tester.pump();

      final findCountryTileFavoriteButtonAgain =
          find.widgetWithIcon(CountryTile, Icons.favorite_outline);
      expect(findCountryTileFavoriteButtonAgain,
          findsNWidgets(TestModels().exampleList.length));

      verify(addCountryToFavoritesUseCase.call(
          params: TestModels().exampleList.first));
      verify(removeCountryFromFavoritesUseCase.call(
          params: TestModels().exampleList.first));
    });

    testWidgets("widget should display error after second tap",
        (WidgetTester tester) async {
      when(removeCountryFromFavoritesUseCase.call(
              params: TestModels().exampleList.first))
          .thenAnswer(
              (realInvocation) async => Left(TestModels().exampleFailure));
      await _buildWidget(tester);

      final findCountryTileFavoriteButton = find.byIcon(Icons.favorite_outline);
      expect(findCountryTileFavoriteButton, findsWidgets);

      await tester.tap(findCountryTileFavoriteButton.first);
      await tester.pump();

      final findCountryTileAddedToFavorites = find.byIcon(Icons.favorite);
      expect(findCountryTileAddedToFavorites, findsOneWidget);

      await tester.tap(findCountryTileAddedToFavorites.first);
      await tester.pump();

      final findSnackBarWithError =
          find.widgetWithText(SnackBar, TestModels().exampleFailure.message);
      expect(findSnackBarWithError, findsOneWidget);

      final findCountryTileFavoriteButtonAgain =
          find.widgetWithIcon(CountryTile, Icons.favorite_outline);
      expect(findCountryTileFavoriteButtonAgain,
          findsNWidgets(TestModels().exampleList.length - 1));

      verify(addCountryToFavoritesUseCase.call(
          params: TestModels().exampleList.first));
      verify(removeCountryFromFavoritesUseCase.call(
          params: TestModels().exampleList.first));
    });

    testWidgets("Widget list should scroll", (WidgetTester tester) async {
      when(getAllCountriesListDataUseCase.call()).thenAnswer(
          (realInvocation) async => Right(TestModels().exampleListLong));
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findScrollList = find.byType(Scrollable);
      final findLastCountryTile = find.widgetWithText(
          CountryTile, TestModels().exampleListLong.last.country);

      await tester.scrollUntilVisible(findLastCountryTile, 5000.0,
          scrollable: findScrollList);

      expect(findLastCountryTile, findsOneWidget);
    });

    testWidgets("Widget should display error on failure",
        (WidgetTester tester) async {
      when(getAllCountriesListDataUseCase.call()).thenAnswer(
          (realInvocation) async => Left(TestModels().exampleFailure));
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findError =
          find.textContaining(TestModels().exampleFailure.message);
      final findCenter = find.byType(Center);

      expect(findError, findsOneWidget);
      expect(findCenter, findsOneWidget);
    });
  });

  group("app bar", () {
    testWidgets("widget should contain app bar", (WidgetTester tester) async {
      await _buildWidget(tester);

      final findAppBar = find.byType(AppBar);

      expect(findAppBar, findsOneWidget);
    });
  });
}
