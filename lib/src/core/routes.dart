import 'package:auto_route/auto_route.dart';
import 'package:covid_app/src/presentation/pages/countries_list_page.dart';
import 'package:covid_app/src/presentation/pages/favorites_page.dart';
import 'package:covid_app/src/presentation/pages/global_data_page.dart';
import 'package:covid_app/src/presentation/pages/home_page.dart';

@AdaptiveAutoRouter(replaceInRouteName: "Page,Screen,Route", routes: <
    AutoRoute>[
  AutoRoute(
      path: "/",
      page: HomePage,
      children: [
    AutoRoute(path: 'global', name: "GlobalDataRouter", page: GlobalDataPage),
    AutoRoute(
        path: "countries",
        name: "CountriesListRouter",
        page: CountriesListPage),
    AutoRoute(path: "favorites", name: "FavoritesRouter", page: FavoritesPage)
  ])
])
class $AppRouter {}
