import 'dart:math';

import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountriesListCubit cubit = BlocProvider.of<CountriesListCubit>(context);
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<CountriesListCubit, CountriesListState>(
            builder: (BuildContext context, state) {
              if (state is CountriesListDone) {
                return _buildDashboard();
              }
              if (state is CountriesListLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              if (state is CountriesListInitial) {
                cubit.refresh();
              }
              if (state is CountriesListError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          )),
    );
  }

  Widget _buildDashboard() {
    return BlocBuilder<CountriesListCubit, CountriesListState>(
      builder: (context, state) {
        state = state as CountriesListDone;
        int countriesLength = state.countries.length;
        return Column(
          children: [
            SizedBox(
              child: OutlinedButton(
                onPressed: () {
                  int rand = Random().nextInt(countriesLength);
                  BlocProvider.of<CountriesListCubit>(context).selectCountry(rand);
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
