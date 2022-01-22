// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:covid_app/src/presentation/pages/countries_list_page.dart'
    as _i3;
import 'package:covid_app/src/presentation/pages/favorites_page.dart' as _i4;
import 'package:covid_app/src/presentation/pages/global_data_page.dart' as _i2;
import 'package:covid_app/src/presentation/pages/home_page.dart' as _i1;
import 'package:flutter/material.dart' as _i6;

class AutoRouter extends _i5.RootStackRouter {
  AutoRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    GlobalDataRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.GlobalDataPage());
    },
    CountriesListRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.CountriesListPage());
    },
    FavoritesRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.FavoritesPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomePageRoute.name, path: '/', children: [
          _i5.RouteConfig(GlobalDataRouter.name,
              path: 'global', parent: HomePageRoute.name),
          _i5.RouteConfig(CountriesListRouter.name,
              path: 'countries', parent: HomePageRoute.name),
          _i5.RouteConfig(FavoritesRouter.name,
              path: 'favorites', parent: HomePageRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i5.PageRouteInfo<void> {
  const HomePageRoute({List<_i5.PageRouteInfo>? children})
      : super(HomePageRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.GlobalDataPage]
class GlobalDataRouter extends _i5.PageRouteInfo<void> {
  const GlobalDataRouter() : super(GlobalDataRouter.name, path: 'global');

  static const String name = 'GlobalDataRouter';
}

/// generated route for
/// [_i3.CountriesListPage]
class CountriesListRouter extends _i5.PageRouteInfo<void> {
  const CountriesListRouter()
      : super(CountriesListRouter.name, path: 'countries');

  static const String name = 'CountriesListRouter';
}

/// generated route for
/// [_i4.FavoritesPage]
class FavoritesRouter extends _i5.PageRouteInfo<void> {
  const FavoritesRouter() : super(FavoritesRouter.name, path: 'favorites');

  static const String name = 'FavoritesRouter';
}
