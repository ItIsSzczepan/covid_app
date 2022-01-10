import 'package:covid_app/src/presentation/cubit/summary_cubit.dart';
import 'package:covid_app/src/presentation/pages/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/injector.dart';

void main() async{
  await initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SummaryCubit>(create: (_) => injector()..refresh(),
    child: const MaterialApp(
        home: SummaryPage(),
    ),);
  }
}

