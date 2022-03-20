import 'package:auto_route/auto_route.dart';
import 'package:covid_app/src/injector.dart';
import 'package:covid_app/src/presentation/cubit/favorites_countries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubitWrapPage extends StatelessWidget {
  const FavoritesCubitWrapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesCountriesCubit>(
        create: (context) => injector(), child: AutoRouter());
  }
}
