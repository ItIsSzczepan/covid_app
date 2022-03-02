import 'package:auto_route/auto_route.dart';
import 'package:covid_app/src/presentation/pages/countries_list_page.dart';
import 'package:covid_app/src/presentation/pages/favorites_cubit_wrap_page.dart';
import 'package:covid_app/src/presentation/pages/favorites_page.dart';
import 'package:covid_app/src/presentation/pages/global_data_page.dart';
import 'package:covid_app/src/presentation/pages/home_page.dart';

@AdaptiveAutoRouter(
    replaceInRouteName: "Page,Screen,Route",
    routes: <AutoRoute>[
      AutoRoute(path: "/", page: HomePage, children: [
        AutoRoute(
            path: 'global', name: "GlobalDataRouter", page: GlobalDataPage),
        AutoRoute(
            path: "countries",
            name: "CountriesListRouter",
            page: FavoritesCubitWrapPage,
            children: [
              AutoRoute(path: "", page: CountriesListPage),
              RedirectRoute(path: "*", redirectTo: "")
            ]),
        AutoRoute(
            path: "favorites",
            name: "FavoritesRouter",
            page: FavoritesCubitWrapPage,
            children: [
              AutoRoute(path: "", page: FavoritesPage),
              RedirectRoute(path: "*", redirectTo: "")
            ])
      ])
    ])
class $AppRouter {}
