import 'dart:math';

import 'package:covid_app/src/presentation/cubit/summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SummaryCubit cubit = BlocProvider.of<SummaryCubit>(context);
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<SummaryCubit, SummaryState>(
            builder: (BuildContext context, state) {
              if (state is SummaryDone) {
                return _buildDashboard();
              }
              if (state is SummaryLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              if (state is SummaryInitial) {
                cubit.refresh();
              }
              if (state is SummaryError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          )),
    );
  }

  Widget _buildDashboard() {
    return BlocBuilder<SummaryCubit, SummaryState>(
      builder: (context, state) {
        state = state as SummaryDone;
        int countriesLength = state.countries.length;
        return Column(
          children: [
            SizedBox(
              child: OutlinedButton(
                onPressed: () {
                  int rand = Random().nextInt(countriesLength);
                  BlocProvider.of<SummaryCubit>(context).selectCountry(rand);
                },
                child: Text(state.countries[state.selectedCountry].country),
              ),
              height: 50.0,
            ),
            Text(state.countries[state.selectedCountry].cases.toString()),
            Text(state.countries[state.selectedCountry].todayCases.toString()),
            Text(state.countries[state.selectedCountry].todayRecovered.toString()),
            Text(state.countries[state.selectedCountry].recovered.toString()),
            Text(state.countries[state.selectedCountry].todayDeaths.toString()),
            Text(state.countries[state.selectedCountry].deaths.toString()),
          ],
        );
      },
    );
  }
}
