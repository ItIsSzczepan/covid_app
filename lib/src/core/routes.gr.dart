// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:covid_app/src/presentation/pages/countries_list_page.dart'
    as _i4;
import 'package:covid_app/src/presentation/pages/favorites_cubit_wrap_page.dart'
    as _i3;
import 'package:covid_app/src/presentation/pages/favorites_page.dart' as _i5;
import 'package:covid_app/src/presentation/pages/global_data_page.dart' as _i2;
import 'package:covid_app/src/presentation/pages/home_page.dart' as _i1;
import 'package:flutter/material.dart' as _i7;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    GlobalDataRouter.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.GlobalDataPage());
    },
    CountriesListRouter.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.FavoritesCubitWrapPage());
    },
    FavoritesRouter.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.FavoritesCubitWrapPage());
    },
    CountriesListPageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.CountriesListPage());
    },
    FavoritesPageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.FavoritesPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(HomePageRoute.name, path: '/', children: [
          _i6.RouteConfig(GlobalDataRouter.name,
              path: 'global', parent: HomePageRoute.name),
          _i6.RouteConfig(CountriesListRouter.name,
              path: 'countries',
              parent: HomePageRoute.name,
              children: [
                _i6.RouteConfig(CountriesListPageRoute.name,
                    path: '', parent: CountriesListRouter.name),
                _i6.RouteConfig('*#redirect',
                    path: '*',
                    parent: CountriesListRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i6.RouteConfig(FavoritesRouter.name,
              path: 'favorites',
              parent: HomePageRoute.name,
              children: [
                _i6.RouteConfig(FavoritesPageRoute.name,
                    path: '', parent: FavoritesRouter.name),
                _i6.RouteConfig('*#redirect',
                    path: '*',
                    parent: FavoritesRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ])
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomePageRoute extends _i6.PageRouteInfo<void> {
  const HomePageRoute({List<_i6.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomePageRoute';
}

/// generated route for [_i2.GlobalDataPage]
class GlobalDataRouter extends _i6.PageRouteInfo<void> {
  const GlobalDataRouter() : super(name, path: 'global');

  static const String name = 'GlobalDataRouter';
}

/// generated route for [_i3.FavoritesCubitWrapPage]
class CountriesListRouter extends _i6.PageRouteInfo<void> {
  const CountriesListRouter({List<_i6.PageRouteInfo>? children})
      : super(name, path: 'countries', initialChildren: children);

  static const String name = 'CountriesListRouter';
}

/// generated route for [_i3.FavoritesCubitWrapPage]
class FavoritesRouter extends _i6.PageRouteInfo<void> {
  const FavoritesRouter({List<_i6.PageRouteInfo>? children})
      : super(name, path: 'favorites', initialChildren: children);

  static const String name = 'FavoritesRouter';
}

/// generated route for [_i4.CountriesListPage]
class CountriesListPageRoute extends _i6.PageRouteInfo<void> {
  const CountriesListPageRoute() : super(name, path: '');

  static const String name = 'CountriesListPageRoute';
}

/// generated route for [_i5.FavoritesPage]
class FavoritesPageRoute extends _i6.PageRouteInfo<void> {
  const FavoritesPageRoute() : super(name, path: '');

  static const String name = 'FavoritesPageRoute';
}
