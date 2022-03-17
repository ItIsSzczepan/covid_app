import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:covid_app/src/presentation/widgets/country_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoritesCountriesCubit cubit = BlocProvider.of<FavoritesCountriesCubit>(context);

    return Scaffold(
      key: const Key("Favorites Scaffold"),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.favorites),
      ),
      body: BlocBuilder<FavoritesCountriesCubit, Stream<List<Country>>>(
          bloc: cubit,
          builder: (context, state) {
            return StreamBuilder<List<Country>>(
                stream: state,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return _buildList(context, snapshot.data!);
                  }

                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return _buildEmptyMessage(context);
                  }

                  return Container();
                });
          }),
    );
  }

  Widget _buildEmptyMessage(BuildContext context) {
    return Center(child: Text(AppLocalizations.of(context)!.emptyFav));
  }

  Widget _buildList(BuildContext context, List<Country> data) {
    CountriesListCubit allCountriesCubit = BlocProvider.of<CountriesListCubit>(context);

    return RefreshIndicator(
      onRefresh: () => allCountriesCubit.load(),
      child: ListView.separated(
          itemBuilder: (context, index) {
            Country country = data[index];

            return CountryTile(
                country: country,
                buttonWidget: IconButton(
                  onPressed: () => _removeCountryFromFavorites(context, country),
                  icon: const Icon(Icons.delete_outlined),
                ));
          },
          separatorBuilder: (_, i) => const Divider(),
          itemCount: data.length),
    );
  }

  _removeCountryFromFavorites(BuildContext context, Country country) {
    FavoritesCountriesCubit cubit =
        BlocProvider.of<FavoritesCountriesCubit>(context);

    cubit.removeCountryFromFavorites(
        country, (error) => _showSnackBarMessage(context, error.message));
  }

  _showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
