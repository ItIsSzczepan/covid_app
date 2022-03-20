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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
            "${AppLocalizationsEn().cases}\n${TestModels().exampleList.first.todayCases.toString()}\n${TestModels().exampleList.first.cases.toString()}"),
        find.widgetWithText(CountryTile,
            "${AppLocalizationsEn().deaths}\n${TestModels().exampleList.first.todayDeaths.toString()}\n${TestModels().exampleList.first.deaths.toString()}"),
        find.widgetWithText(CountryTile,
            "${AppLocalizationsEn().recovered}\n${TestModels().exampleList.first.todayRecovered.toString()}\n${TestModels().exampleList.first.recovered.toString()}"),
      ];

      for (var value in countryTileDataFinders) {
        expect(value, findsOneWidget);
      }
    });

    testWidgets("widget should reload data after pull", (WidgetTester tester) async {
      reset(getAllCountriesListDataUseCase);
      final SemanticsHandle handle = tester.ensureSemantics();

      await _buildWidget(tester);

      await tester.fling(find.byType(CountryTile).first, const Offset(0.0, 300.0), 1000.0);
      await tester.pump();

      expect(
          tester.getSemantics(find.byType(RefreshProgressIndicator)),
          matchesSemantics(
            label: 'Refresh',
          ));

      await tester
          .pump(const Duration(seconds: 1)); // finish the scroll animation
      await tester.pump(
          const Duration(seconds: 1)); // finish the indicator settle animation
      await tester.pump(
          const Duration(seconds: 1)); // finish the indicator hide animation

      verify(getAllCountriesListDataUseCase.call()).called(2);

      handle.dispose();
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

      expect(findError, findsOneWidget);
    });
  });

  group("app bar and search", () {
    testWidgets("widget should contain app bar", (WidgetTester tester) async {
      await _buildWidget(tester);

      final findAppBar = find.byType(AppBar);

      expect(findAppBar, findsOneWidget);
    });

    testWidgets("app bar contain search icon", (WidgetTester tester)async{
      await _buildWidget(tester);

      final findSearchIconInAppBar = find.widgetWithIcon(AppBar, Icons.search);

      expect(findSearchIconInAppBar, findsOneWidget);
    });

    testWidgets("app should show text field widget after tap on search icon", (WidgetTester tester)async{
      await _buildWidget(tester);

      final findSearchButton = find.byIcon(Icons.search);
      await tester.tap(findSearchButton);
      await tester.pump();

      final findTextField = find.byType(TextField);

      expect(findTextField, findsOneWidget);
    });

    testWidgets("app should hide text field after tap on back arrow", (WidgetTester tester)async{
      await _buildWidget(tester);

      final findSearchButton = find.byIcon(Icons.search);
      await tester.tap(findSearchButton);
      await tester.pump();

      final findTextField = find.byType(TextField);

      expect(findTextField, findsOneWidget);

      final findBackArrow = find.byIcon(Icons.arrow_back);
      await tester.tap(findBackArrow);
      await tester.pump();

      expect(findTextField, findsNothing);
    });

    testWidgets("app should return countries right for search", (WidgetTester tester) async {
      await _buildWidget(tester);

      final findSearchButton = find.byIcon(Icons.search);
      await tester.tap(findSearchButton);
      await tester.pump();

      final findTextField = find.byType(TextField);
      await tester.enterText(findTextField, "pol");
      await tester.pump(const Duration(seconds: 1));

      final findGermany = find.text("Germany");
      final findPoland = find.text("Poland");

      expect(findGermany, findsNothing);
      expect(findPoland, findsOneWidget);
    });

    testWidgets("app should return all countries after search bar are closed", (WidgetTester tester) async {
      await _buildWidget(tester);

      final findSearchButton = find.byIcon(Icons.search);
      await tester.tap(findSearchButton);
      await tester.pump();

      final findTextField = find.byType(TextField);
      await tester.enterText(findTextField, "pol");
      await tester.pump();

      final findGermany = find.text("Germany");
      final findPoland = find.text("Poland");

      expect(findGermany, findsNothing);
      expect(findPoland, findsOneWidget);

      final findBackArrow = find.byIcon(Icons.arrow_back);
      await tester.tap(findBackArrow);
      await tester.pump();

      expect(findGermany, findsOneWidget);
      expect(findPoland, findsOneWidget);
    });

  });
}
