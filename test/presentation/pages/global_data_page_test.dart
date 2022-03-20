import 'package:covid_app/src/core/failure.dart';
import 'package:covid_app/src/data/models/record_model.dart';
import 'package:covid_app/src/domain/use_cases/get_global_data_usecase.dart';
import 'package:covid_app/src/presentation/cubit/global_data_cubit.dart';
import 'package:covid_app/src/presentation/pages/global_data_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'global_data_page_test.mocks.dart';

@GenerateMocks([GetGlobalDataUseCase, GlobalDataCubit])
void main() {
  late final GetGlobalDataUseCase _usecase;
  late GlobalDataCubit _cubit;
  late Widget testPage;

  const RecordModel testRecord = RecordModel(
    updated: 12341234,
      todayCases: 2000,
      cases: 4000,
      todayDeaths: 50,
      deaths: 500,
      todayRecovered: 400,
      recovered: 900);

  final Failure testFailure = Failure("You fucked up");

  setUpAll(() {
    _usecase = MockGetGlobalDataUseCase();
  });

  setUp((){
    _cubit = GlobalDataCubit(_usecase);
    testPage = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<GlobalDataCubit>(
        create: (_) => _cubit..load(),
        child: const GlobalDataPage(),
      ),
    );
  });

  tearDownAll((){
    _cubit.close();
  });

  testWidgets("placeholder at init", (WidgetTester tester) async {
    when(_usecase.call())
        .thenAnswer((realInvocation)  async => const Right(testRecord));

    await tester.pumpWidget(testPage);

    final findShimmers = find.byType(Shimmer);
    expect(findShimmers, findsNWidgets(3));
  });

  testWidgets("pull and refresh", (WidgetTester tester) async {
    reset(_usecase);
    when(_usecase.call())
        .thenAnswer((realInvocation) async => const Right(testRecord));

    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(testPage);
    await tester.pump(const Duration(milliseconds: 100));

    await tester.flingFrom(const Offset(200.0, 150.0), const Offset(0.0, 300.0), 1000.0);
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

    verify(_usecase.call()).called(2);

    handle.dispose();
  });

  testWidgets("data is displayed", (WidgetTester tester)async{
    when(_usecase.call())
        .thenAnswer((realInvocation) async => const Right(testRecord));

    await tester.pumpWidget(testPage);
    await tester.pump(const Duration(milliseconds: 100));

    // find labels
    final findTextCases = find.text("Cases");
    final findTextDeaths = find.text("Deaths");
    final findTextRecovered = find.text("Recovered");
    final findTextToday = find.text("Today");
    final findTextAll = find.text("All");

    // find data
    final findTodayCases = find.text(testRecord.todayCases.toString());
    final findCases = find.text(testRecord.cases.toString());
    final findTodayDeaths = find.text(testRecord.todayDeaths.toString());
    final findDeaths = find.text(testRecord.deaths.toString());
    final findTodayRecovered = find.text(testRecord.todayRecovered.toString());
    final findRecovered = find.text(testRecord.recovered.toString());

    // check labels
    expect(findTextCases, findsOneWidget);
    expect(findTextDeaths, findsOneWidget);
    expect(findTextRecovered, findsOneWidget);
    expect(findTextToday, findsNWidgets(3));
    expect(findTextAll, findsNWidgets(3));

    // check data
    expect(findCases, findsOneWidget);
    expect(findTodayCases, findsOneWidget);
    expect(findDeaths, findsOneWidget);
    expect(findTodayDeaths, findsOneWidget);
    expect(findRecovered, findsOneWidget);
    expect(findTodayRecovered, findsOneWidget);
  });

  testWidgets("display error", (WidgetTester tester) async {
    when(_usecase.call()).thenAnswer((realInvocation) async => Left(testFailure));

    await tester.pumpWidget(testPage);
    await tester.pump(const Duration(milliseconds: 100));

    final findErrorText = find.text(testFailure.message);
    final findCenterWidget = find.byType(Center);

    expect(findErrorText, findsOneWidget);
    expect(findCenterWidget, findsOneWidget);
  });

  testWidgets("check if app bar is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(testPage);

    final findTitle = find.text("Global");
    final findAppBar = find.byType(AppBar);

    expect(findTitle, findsOneWidget);
    expect(findAppBar, findsOneWidget);
  });
}
