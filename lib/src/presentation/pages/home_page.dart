import 'package:auto_route/auto_route.dart';
import 'package:covid_app/src/core/routes.gr.dart';
import 'package:flutter/material.dart';

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
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.public), label: "Global"),
              BottomNavigationBarItem(icon: Icon(Icons.flag), label: "Countries"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
            ]
        );
      },
    );
  }
}
