import 'package:covid_app/src/domain/entities/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryTile extends StatelessWidget {
  final Country country;
  final Widget buttonWidget;

  const CountryTile(
      {Key? key,
      required this.country,
      required this.buttonWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(country.country),
      isThreeLine: true,
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${AppLocalizations.of(context)!.cases}\n${country.todayCases}\n${country.cases}",
            textAlign: TextAlign.left,
          ),
          Text(
            "${AppLocalizations.of(context)!.deaths}\n${country.todayDeaths}\n${country.deaths}",
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.red),
          ),
          Text(
            "${AppLocalizations.of(context)!.recovered}\n${country.todayRecovered}\n${country.recovered}",
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.green),
          ),
        ],
      ),
      trailing: buttonWidget,
    );
  }
}
