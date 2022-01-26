import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:covid_app/src/presentation/widgets/country_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

class CountriesListPage extends StatelessWidget {
  const CountriesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountriesListCubit cubit = BlocProvider.of<CountriesListCubit>(context);

    return Scaffold(
      key: const Key("Country list Scaffold"),
      appBar: AppBar(
        title: const Text("Countries"),
      ),
      body: SafeArea(
          child: BlocBuilder<FavoritesCountriesCubit, Stream<List<Country>>>(
        builder: (context, favoritesStream) {
          return StreamBuilder<List<Country>>(
              stream: favoritesStream,
              builder: (context, favoritesCountries) {
                return BlocBuilder<CountriesListCubit, CountriesListState>(
                  builder: (BuildContext context, state) {
                    if (state is CountriesListDone) {
                      return _buildDashboard(
                          context, state, favoritesCountries.data ?? []);
                    }
                    if (state is CountriesListLoading) {
                      return _buildPlaceholders();
                    }
                    if (state is CountriesListInitial) {
                      cubit.load();
                    }
                    if (state is CountriesListError) {
                      return _buildError(state.message);
                    }
                    return Container();
                  },
                );
              });
        },
      )),
    );
  }

  Widget _buildDashboard(
      BuildContext context, CountriesListState state, List<Country> favorites) {
    final countries = (state as CountriesListDone).countries;
    final List<String> favCountriesNames =
        favorites.map((e) => e.country).toList();

    return ListView.separated(
        itemBuilder: (context, i) {
          final Country country = countries[i];
          bool inFavorites = favCountriesNames.contains(country.country);

          return CountryTile(
              country: country,
              buttonWidget: IconButton(
                  icon: Icon(
                    inFavorites ? Icons.favorite : Icons.favorite_outline,
                    color: inFavorites ? Colors.red : Colors.grey,
                  ),
                  onPressed: (){
                    if (inFavorites) {
                      _removeCountryFromFavorites(context, country);
                    } else {
                      _addCountryToFavorites(context, country);
                    }
                  }));
        },
        separatorBuilder: (_, i) => const Divider(),
        itemCount: countries.length);
  }

  _addCountryToFavorites(BuildContext context, Country country) {
    FavoritesCountriesCubit cubit =
        BlocProvider.of<FavoritesCountriesCubit>(context);

    cubit.addCountryToFavorites(
        country, (error) => _showScaffoldError(context, error.message));
  }

  _removeCountryFromFavorites(BuildContext context, Country country) {
    FavoritesCountriesCubit cubit =
        BlocProvider.of<FavoritesCountriesCubit>(context);

    cubit.removeCountryFromFavorites(
        country, (error) => _showScaffoldError(context, error.message));
  }

  _showScaffoldError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildPlaceholders() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return const PlaceholderLines(count: 3);
        });
  }

  Widget _buildError(String message) {
    return Center(
        child: Text(
      message,
      style: const TextStyle(color: Colors.red),
    ));
  }
}
