import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/presentation/cubit/global_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class GlobalDataPage extends StatelessWidget {
  const GlobalDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalDataCubit cubit = BlocProvider.of<GlobalDataCubit>(context);
    return Scaffold(
      key: const Key("Global Scaffold"),
      appBar: AppBar(
        title: const Text("Global"),
      ),
      body: SafeArea(
        child: BlocBuilder<GlobalDataCubit, GlobalDataState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is GlobalDataLoading) {
              return _buildPlaceholders();
            }

            if (state is GlobalDataError) {
              return _buildError(state.message);
            }

            if (state is GlobalDataDone) {
              return _buildData(context, state.data);
            }

            return const Text("");
          },
        ),
      ),
    );
  }

  Widget _buildData(BuildContext context, Record record) {
    return Column(
      children: [
        _buildDataContainer(
            context, "Cases", record.todayCases, record.cases, Colors.white24),
        Row(children: [
          Flexible(
              flex: 1,
              child: _buildDataContainer(context, "Deaths", record.todayDeaths,
                  record.deaths, Colors.red)),
          Flexible(
              flex: 1,
              child: _buildDataContainer(context, "Recovered",
                  record.todayRecovered, record.recovered, Colors.green))
        ])
      ],
    );
  }

  Widget _buildDataContainer(
      BuildContext context, String title, int today, int all, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            "Today",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            today.toString(),
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            "All",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            all.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholders() {
    return Column(
      children: [
        _buildPlaceholderBox(),
        Row(
          children: [
            Flexible(flex: 1, child: _buildPlaceholderBox()),
            Flexible(flex: 1, child: _buildPlaceholderBox())
          ],
        )
      ],
    );
  }

  Widget _buildPlaceholderBox() {
    return Shimmer.fromColors(
        child: Container(
          height: 150,
        ),
        baseColor: Colors.grey,
        highlightColor: Colors.white);
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
