import 'package:equatable/equatable.dart';

class Record extends Equatable {
  final int cases;
  final int todayCases;
  final int todayDeaths;
  final int deaths;
  final int todayRecovered;
  final int recovered;

  const Record(
      {required this.cases,
      required this.todayCases,
      required this.todayDeaths,
      required this.deaths,
      required this.todayRecovered,
      required this.recovered});

  @override
  List<Object?> get props => [
        cases,
        todayCases,
        todayDeaths,
        deaths,
        todayRecovered,
        recovered
      ];

}
