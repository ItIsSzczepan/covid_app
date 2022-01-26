import 'package:covid_app/src/domain/entities/country.dart';
import 'package:flutter/material.dart';

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
            "Cases\n${country.todayCases}\n${country.cases}",
            textAlign: TextAlign.left,
          ),
          Text(
            "Deaths\n${country.todayDeaths}\n${country.deaths}",
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.red),
          ),
          Text(
            "Recovered\n${country.todayRecovered}\n${country.recovered}",
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.green),
          ),
        ],
      ),
      trailing: buttonWidget,
    );
  }
}
