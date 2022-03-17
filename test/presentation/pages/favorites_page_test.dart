import 'dart:async';

import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/add_country_to_favorites_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_favorites_countries_usecase.dart';
import 'package:covid_app/src/domain/use_cases/remove_country_from_favorites_usecase.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:covid_app/src/presentation/pages/favorites_page.dart';
import 'package:covid_app/src/presentation/widgets/country_tile.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../models.dart';
import 'favorites_page_test.mocks.dart';

@GenerateMocks([
  GetFavoritesCountriesUseCase,
  AddCountryToFavoritesUseCase,
  RemoveCountryFromFavoritesUseCase,
  CountriesListCubit
])
void main() {
  late final GetFavoritesCountriesUseCase getFavoritesCountriesUseCase;
  late final AddCountryToFavoritesUseCase addCountryToFavoritesUseCase;
  late final RemoveCountryFromFavoritesUseCase
      removeCountryFromFavoritesUseCase;
  late final CountriesListCubit countriesListCubit;
  late FavoritesCountriesCubit cubit;
  late Widget testPage;
  late StreamController<List<Country>> _streamController;

  setUpAll(() {
    getFavoritesCountriesUseCase = MockGetFavoritesCountriesUseCase();
    addCountryToFavoritesUseCase = MockAddCountryToFavoritesUseCase();
    removeCountryFromFavoritesUseCase = MockRemoveCountryFromFavoritesUseCase();
    countriesListCubit = MockCountriesListCubit();
  });

  setUp(() {
    List<Country> testList = TestModels().exampleList;
    _streamController = StreamController<List<Country>>()..add(testList);
    Stream<List<Country>> _stream = _streamController.stream;

    when(countriesListCubit.stream).thenAnswer((_)=> Stream.empty());

    when(getFavoritesCountriesUseCase.call())
        .thenAnswer((realInvocation) async => Right(_stream));
    when(removeCountryFromFavoritesUseCase.call(
            params: TestModels().exampleList.first))
        .thenAnswer((realInvocation) async {
      testList.remove(TestModels().exampleList.first);
      _streamController.add(testList);
      return const Right(null);
    });
    when(removeCountryFromFavoritesUseCase.call(
            params: TestModels().exampleList[1]))
        .thenAnswer((realInvocation) async {
      testList.remove(TestModels().exampleList[1]);
      _streamController.add(testList);
      return const Right(null);
    });

    cubit = FavoritesCountriesCubit(getFavoritesCountriesUseCase,
        addCountryToFavoritesUseCase, removeCountryFromFavoritesUseCase);

    testPage = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<FavoritesCountriesCubit>(
            create: (_) => cubit,
          ),
          BlocProvider<CountriesListCubit>(
            create: (_) => countriesListCubit,
          )
        ],
        child: const FavoritesPage(),
      ),
    );
  });

  group("loading and manipulating data", () {
    testWidgets("widget should display CountryTile after loading data",
        (WidgetTester tester) async {
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findCountryTiles = find.byType(CountryTile);

      expect(findCountryTiles, findsNWidgets(TestModels().exampleList.length));
    });

    testWidgets("widget data list should scroll", (WidgetTester tester) async {
      _streamController.add(TestModels().exampleListLong);
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findScrollable = find.byType(Scrollable);
      final findLastItem = find.text(TestModels().exampleListLong.last.country);

      await tester.scrollUntilVisible(findLastItem, 500.0,
          scrollable: findScrollable);

      expect(findLastItem, findsOneWidget);
    });

    testWidgets("widget should display CountryTile with data",
        (WidgetTester tester) async {
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final List<Finder> finds = [
        find.widgetWithText(
            CountryTile, TestModels().exampleList.first.country),
        find.textContaining(
            TestModels().exampleList.first.todayCases.toString()),
        find.textContaining(TestModels().exampleList.first.cases.toString()),
        find.textContaining(
            TestModels().exampleList.first.todayDeaths.toString()),
        find.textContaining(TestModels().exampleList.first.deaths.toString()),
        find.textContaining(
            TestModels().exampleList.first.todayRecovered.toString()),
        find.textContaining(
            TestModels().exampleList.first.recovered.toString()),
      ];

      for (var value in finds) {
        expect(value, findsWidgets);
      }
    });

    testWidgets(
        "widget should display remove CountryTile after tap on remove icon",
        (WidgetTester tester) async {
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findListOfCountriesOnBeginning = find.byType(CountryTile);
      expect(findListOfCountriesOnBeginning,
          findsNWidgets(TestModels().exampleList.length));

      final findFirstRemoveIcon = find.byIcon(Icons.delete_outlined).first;
      await tester.tap(findFirstRemoveIcon);
      await tester.pump();

      final findListOfCountriesAfterRemovingOne = find.byType(CountryTile);
      final findRemovedCountryName = find.text("Poland");

      expect(findListOfCountriesAfterRemovingOne,
          findsNWidgets(TestModels().exampleList.length - 1));
      expect(findRemovedCountryName, findsNothing);
    });

    testWidgets("widget should display error", (WidgetTester tester) async {
      when(removeCountryFromFavoritesUseCase.call(
              params: TestModels().exampleList.first))
          .thenAnswer(
              (realInvocation) async => Left(TestModels().exampleFailure));
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findListOfCountriesOnBeginning = find.byType(CountryTile);
      expect(findListOfCountriesOnBeginning,
          findsNWidgets(TestModels().exampleList.length));

      final findFirstRemoveIcon = find.byIcon(Icons.delete_outlined).first;
      await tester.tap(findFirstRemoveIcon);
      await tester.pump();

      final findSnackBarError = find.byType(SnackBar);
      final findErrorText = find.text(TestModels().exampleFailure.message);
      final findListOfCountriesAfterRemovingOne = find.byType(CountryTile);
      final findRemovedCountryName = find.text("Poland");

      expect(findSnackBarError, findsOneWidget);
      expect(findErrorText, findsOneWidget);
      expect(findListOfCountriesAfterRemovingOne,
          findsNWidgets(TestModels().exampleList.length));
      expect(findRemovedCountryName, findsOneWidget);
    });

    testWidgets("widget should display information about list is empty",
        (WidgetTester tester) async {
      _streamController.add([]);

      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findCountryTiles = find.byType(CountryTile);

      expect(findCountryTiles, findsNothing);

      final findEmptyText = find.textContaining(AppLocalizationsEn().emptyFav);
      expect(findEmptyText, findsOneWidget);
    });

    testWidgets(
        "widget should display remove CountryTile after tap on remove icon",
        (WidgetTester tester) async {
      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findListOfCountriesOnBeginning = find.byType(CountryTile);
      expect(findListOfCountriesOnBeginning,
          findsNWidgets(TestModels().exampleList.length));

      final findRemoveIcons = find.byIcon(Icons.delete_outlined);
      await tester.tap(findRemoveIcons.first);
      await tester.tap(findRemoveIcons.last);
      await tester.pump();

      final findListOfCountriesAfterRemovingOne = find.byType(CountryTile);
      final findRemovedCountryName = find.text("Poland");
      final findRemovedCountryName2 = find.text("Germany");

      expect(findListOfCountriesAfterRemovingOne, findsNothing);
      expect(findRemovedCountryName, findsNothing);
      expect(findRemovedCountryName2, findsNothing);

      final findEmptyMessage =
          find.textContaining(AppLocalizationsEn().emptyFav);
      expect(findEmptyMessage, findsOneWidget);
    });
  });

  group("check ui", () {
    testWidgets("app bar is displaying", (WidgetTester tester) async {
      await tester.pumpWidget(testPage);

      final findAppBar = find.byType(AppBar);
      final findAppBarTitle =
          find.widgetWithText(AppBar, AppLocalizationsEn().favorites);

      expect(findAppBar, findsOneWidget);
      expect(findAppBarTitle, findsOneWidget);
    });
  });
}
