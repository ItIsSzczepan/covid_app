import 'package:covid_app/src/core/routes.gr.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/injector.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountriesListCubit>(create: (_) => injector()..load(),
    child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    ),);
  }
}

