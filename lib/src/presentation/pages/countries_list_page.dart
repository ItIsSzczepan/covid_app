import 'package:covid_app/src/domain/entities/country.dart';
import 'package:covid_app/src/presentation/cubit/countries_list_cubit.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:covid_app/src/presentation/cubit/search_cubit.dart';
import 'package:covid_app/src/presentation/widgets/country_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class CountriesListPage extends StatefulWidget {
  const CountriesListPage({Key? key}) : super(key: key);

  @override
  State<CountriesListPage> createState() => _CountriesListPageState();
}

class _CountriesListPageState extends State<CountriesListPage> {
  late SearchBar searchBar;
  late SearchCubit searchCubit;

  _CountriesListPageState() {
    searchCubit = SearchCubit();
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        onChanged: (text) {
          searchCubit.edit(text);
        },
        onClosed: () => searchCubit.clear(),
        onCleared: () => searchCubit.clear(),
        buildDefaultAppBar: _buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    CountriesListCubit cubit = BlocProvider.of<CountriesListCubit>(context);
    FavoritesCountriesCubit favoritesCountriesCubit =
        BlocProvider.of<FavoritesCountriesCubit>(context);

    return Scaffold(
      key: const Key("Country list Scaffold"),
      appBar: searchBar.build(context),
      body: SafeArea(
          child: BlocBuilder<FavoritesCountriesCubit, Stream<List<Country>>>(
        bloc: favoritesCountriesCubit,
        builder: (context, favoritesStream) {

          return StreamBuilder<List<Country>>(
              stream: favoritesStream,
              builder: (context, favoritesCountries) {

                return BlocBuilder<CountriesListCubit, CountriesListState>(
                  builder: (BuildContext context, state) {
                    if (state is CountriesListDone) {

                      return BlocBuilder<SearchCubit, String>(
                        bloc: searchCubit,
                        builder: (context, searchText) {
                          List<Country> countries =
                              List.from(state.countries);

                          countries.removeWhere((element) => !element.country
                              .toUpperCase()
                              .contains(searchText.toUpperCase()));

                          return _buildDashboard(
                              context, countries, favoritesCountries.data ?? [], cubit.load);
                        },
                      );
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('Countries'),
        actions: [searchBar.getSearchAction(context)]);
  }

  Widget _buildDashboard(BuildContext context, List<Country> countries,
      List<Country> favorites, Function onRefresh) {
    final List<String> favCountriesNames =
        favorites.map((e) => e.country).toList();

    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
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
                    onPressed: () {
                      if (inFavorites) {
                        _removeCountryFromFavorites(context, country);
                      } else {
                        _addCountryToFavorites(context, country);
                      }
                    }));
          },
          separatorBuilder: (_, i) => const Divider(),
          itemCount: countries.length),
    );
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
