import 'package:auto_route/auto_route.dart';
import 'package:covid_app/src/core/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        GlobalDataRouter(),
        CountriesListRouter(),
        FavoritesRouter()
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          key: const Key("bottom nav"),
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.public), label: AppLocalizations.of(context)!.global),
              BottomNavigationBarItem(icon: Icon(Icons.flag), label: AppLocalizations.of(context)!.countries),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: AppLocalizations.of(context)!.favorites),
            ]
        );
      },
    );
  }
}
