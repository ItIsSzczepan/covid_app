import 'package:covid_app/src/domain/entities/record.dart';
import 'package:covid_app/src/presentation/cubit/global_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlobalDataPage extends StatelessWidget {
  const GlobalDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalDataCubit cubit = BlocProvider.of<GlobalDataCubit>(context);
    return Scaffold(
      key: const Key("Global Scaffold"),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.global),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => cubit.load(),
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
      ),
    );
  }

  Widget _buildData(BuildContext context, Record record) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          _buildDataContainer(
              context, AppLocalizations.of(context)!.cases, record.todayCases, record.cases, Colors.grey),
          Row(children: [
            Flexible(
                flex: 1,
                child: _buildDataContainer(context, AppLocalizations.of(context)!.deaths, record.todayDeaths,
                    record.deaths, Colors.red)),
            Flexible(
                flex: 1,
                child: _buildDataContainer(context, AppLocalizations.of(context)!.recovered,
                    record.todayRecovered, record.recovered, Colors.green))
          ])
        ],
      ),
    );
  }

  Widget _buildDataContainer(
      BuildContext context, String title, int today, int all, Color color) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(7.5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(7.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 4,),
          Text(
            AppLocalizations.of(context)!.today,
          ),
          Text(
            today.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            AppLocalizations.of(context)!.all,
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
          height: 125,
          width: double.infinity,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Colors.black
          ),
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white);
  }

  Widget _buildError(String message) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
