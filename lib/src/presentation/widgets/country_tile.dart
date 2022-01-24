import 'package:covid_app/src/domain/entities/country.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatelessWidget {
  final Country country;
  final Function onIconPress;
  final bool inFavorites;

  const CountryTile(
      {Key? key,
      required this.country,
      required this.onIconPress,
      required this.inFavorites})
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
            "Cases\n${country.todayDeaths}\n${country.deaths}",
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.red),
          ),
          Text(
            "Cases\n${country.todayRecovered}\n${country.recovered}",
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.green),
          ),
        ],
      ),
      trailing: IconButton(
          icon: Icon(
            inFavorites ? Icons.favorite : Icons.favorite_outline,
            color: inFavorites ? Colors.red : Colors.grey,
          ),
          onPressed: onIconPress()),
    );
  }
}
