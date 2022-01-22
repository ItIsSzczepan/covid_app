import 'dart:math';

import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesListPage extends StatelessWidget {
  const CountriesListPage({Key? key}) : super(key: key);

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
                cubit.load();
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
        return ListView.separated(itemBuilder: (_, index){
          return Column(children: [
            Text((state as CountriesListDone).countries[index].country),
            Text(state.countries[index].cases.toString()),
            Text(state.countries[index].todayCases.toString()),
            Text(state.countries[index].todayRecovered.toString()),
            Text(state.countries[index].recovered.toString()),
            Text(state.countries[index].todayDeaths.toString()),
            Text(state.countries[index].deaths.toString()),
          ],);
        }, separatorBuilder: (BuildContext context, int index) {return const Divider();}, itemCount: (state as CountriesListDone).countries.length,);
      },
    );
  }
}
