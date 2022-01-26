import 'dart:async';

import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/domain/use_cases/add_country_to_favorites_usecase.dart';
import 'package:covid_app/src/domain/use_cases/get_favorites_countries_usecase.dart';
import 'package:covid_app/src/domain/use_cases/remove_country_from_favorites_usecase.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:covid_app/src/presentation/pages/favorites_page.dart';
import 'package:covid_app/src/presentation/widgets/country_tile.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../models.dart';
import '../cubit/favorites_countries_cubit_test.mocks.dart';

@GenerateMocks([
  GetFavoritesCountriesUseCase,
  AddCountryToFavoritesUseCase,
  RemoveCountryFromFavoritesUseCase
])
void main() {
  late final GetFavoritesCountriesUseCase getFavoritesCountriesUseCase;
  late final AddCountryToFavoritesUseCase addCountryToFavoritesUseCase;
  late final RemoveCountryFromFavoritesUseCase
      removeCountryFromFavoritesUseCase;
  late FavoritesCountriesCubit cubit;
  late Widget testPage;
  late StreamController<List<Country>> _streamController;

  setUpAll(() {
    getFavoritesCountriesUseCase = MockGetFavoritesCountriesUseCase();
    addCountryToFavoritesUseCase = MockAddCountryToFavoritesUseCase();
    removeCountryFromFavoritesUseCase = MockRemoveCountryFromFavoritesUseCase();
  });

  setUp(() {
    List<Country> testList = TestModels().exampleList;
    _streamController = StreamController<List<Country>>()
      ..add(testList);
    Stream<List<Country>> _stream = _streamController.stream;

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
      home: BlocProvider<FavoritesCountriesCubit>(
        create: (_) => cubit,
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

    testWidgets("widget should display information about list is empty",
        (WidgetTester tester) async {
      _streamController.add([]);

      await tester.pumpWidget(testPage);
      await tester.pump(const Duration(milliseconds: 200));

      final findCountryTiles = find.byType(CountryTile);

      expect(findCountryTiles, findsNothing);

      final findEmptyText = find.textContaining("empty");
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

      final findEmptyMessage = find.textContaining("empty");
      expect(findEmptyMessage, findsOneWidget);
    });
  });

  group("check ui", () {
    testWidgets("app bar is displaying", (WidgetTester tester) async {
      await tester.pumpWidget(testPage);

      final findAppBar = find.byType(AppBar);
      final findAppBarTitle = find.widgetWithText(AppBar, "Favorites");

      expect(findAppBar, findsOneWidget);
      expect(findAppBarTitle, findsOneWidget);
    });
  });
}
