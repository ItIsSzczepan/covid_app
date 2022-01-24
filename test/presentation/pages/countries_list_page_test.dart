import 'dart:async';

import 'package:covid_app/src/core/failure.dart';
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
      when(getAllCountriesListDataUseCase.call()).thenAnswer(
          (realInvocation) async => Right(TestModels().exampleList));
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findCountriesTiles = find.byType(CountryTile);
      final findCountryTileWithData = find.widgetWithText(
          CountryTile, TestModels().exampleList.first.country);

      expect(findCountriesTiles, findsWidgets);
      expect(findCountryTileWithData, findsOneWidget);
    });

    testWidgets("widget should display CountryTile with all data",
        (WidgetTester tester) async {
      when(getAllCountriesListDataUseCase.call()).thenAnswer(
          (realInvocation) async => Right(TestModels().exampleList));
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final List<Finder> countryTileDataFinders = [
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.country),
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.todayCases.toString()),
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.cases.toString()),
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.todayDeaths.toString()),
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.deaths.toString()),
        find.widgetWithText(CountryTile,
            TestModels().exampleList.first.todayRecovered.toString()),
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.recovered.toString()),
      ];

      for (var value in countryTileDataFinders) {
        expect(value, findsOneWidget);
      }
    });

    testWidgets(
        "widget should display change favorite icon in CountryTile after click on it",
        (WidgetTester tester) async {
      // test Stream
      StreamController<List<Country>> _streamController =
          StreamController<List<Country>>();
      Stream<List<Country>> _stream = _streamController.stream;

      when(getAllCountriesListDataUseCase.call()).thenAnswer(
          (realInvocation) async => Right(TestModels().exampleList));

      // return stream
      when(getFavoritesCountriesUseCase.call())
          .thenAnswer((realInvocation) async => Right(_stream));

      // add value to stream
      when(addCountryToFavoritesUseCase.call(
              params: TestModels().exampleList.first))
          .thenAnswer((realInvocation) async {
        _streamController.add([realInvocation.positionalArguments.first]);
        return const Right(null);
      });

      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findCountryTileFavoriteButton =
          find.widgetWithIcon(CountryTile, Icons.favorite_outline_sharp);
      expect(findCountryTileFavoriteButton, findsWidgets);

      await tester.tap(findCountryTileFavoriteButton.first);
      await tester.pump();

      final findCountryTileAddedToFavorites =
          find.widgetWithIcon(CountryTile, Icons.favorite);
      expect(findCountryTileAddedToFavorites, findsOneWidget);
    });

    testWidgets(
        "widget should change back favorite icon after second tap",
        (WidgetTester tester) async {
      // test Stream
      StreamController<List<Country>> _streamController =
          StreamController<List<Country>>();
      Stream<List<Country>> _stream = _streamController.stream;

      when(getAllCountriesListDataUseCase.call()).thenAnswer(
          (realInvocation) async => Right(TestModels().exampleList));

      // return stream
      when(getFavoritesCountriesUseCase.call())
          .thenAnswer((realInvocation) async => Right(_stream));

      // add value to stream
      when(addCountryToFavoritesUseCase.call(
              params: TestModels().exampleList.first))
          .thenAnswer((realInvocation) async {
        _streamController.add([realInvocation.positionalArguments.first]);
        return const Right(null);
      });
      
      // remove value from stream
      when(removeCountryFromFavoritesUseCase.call(params: TestModels().exampleList.first)).thenAnswer((realInvocation) async {
        _streamController.add([]);
        return Right(null);
      });

      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findCountryTileFavoriteButton =
          find.widgetWithIcon(CountryTile, Icons.favorite_outline);
      expect(findCountryTileFavoriteButton, findsWidgets);

      await tester.tap(findCountryTileFavoriteButton.first);
      await tester.pump();
      
      final findCountryTileAddedToFavorites = find.widgetWithIcon(CountryTile, Icons.favorite);
      expect(findCountryTileAddedToFavorites, findsOneWidget);
      
      await tester.tap(findCountryTileFavoriteButton);
      await tester.pump();
      
      final findCountryTileFavoriteButtonAgain = find.widgetWithIcon(CountryTile, Icons.favorite_outline);
      expect(findCountryTileFavoriteButtonAgain, findsNWidgets(TestModels().exampleList.length));
      
      verify(addCountryToFavoritesUseCase.call(
              params: TestModels().exampleList.first));
      verify(removeCountryFromFavoritesUseCase.call(params: TestModels().exampleList.first));
    });

    testWidgets("Widget list should scroll", (WidgetTester tester) async {
      await _buildWidget(tester);

      final findScrollList = find.byType(List);
      final findLastCountryTile = find.widgetWithText(CountryTile, TestModels().exampleListLong.last.country);

      await tester.scrollUntilVisible(findLastCountryTile, 1500.0, scrollable: findScrollList);
      
      expect(findLastCountryTile, findsOneWidget);
    });
    
    testWidgets("Widget should display error on failure", (WidgetTester tester) async{
      when(getAllCountriesListDataUseCase.call())
          .thenAnswer((realInvocation) async => Left(TestModels().exampleFailure));
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));
      
      final findError = find.textContaining(TestModels().exampleFailure.message);
      final findCenter = find.byType(Center);
      
      expect(findError, findsOneWidget);
      expect(findCenter, findsOneWidget);
    });
  });

  group("app bar", (){
    testWidgets("widget should contain app bar", (WidgetTester tester) async {
      await _buildWidget(tester);

      final findAppBar = find.byType(AppBar);

      expect(findAppBar, findsOneWidget);
    });
  });
}
