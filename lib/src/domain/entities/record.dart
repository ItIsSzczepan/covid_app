import 'package:equatable/equatable.dart';

class Record extends Equatable {
  final int updated;
  final int cases;
  final int todayCases;
  final int todayDeaths;
  final int deaths;
  final int todayRecovered;
  final int recovered;

  const Record(
      {required this.updated,
      required this.cases,
      required this.todayCases,
      required this.todayDeaths,
      required this.deaths,
      required this.todayRecovered,
      required this.recovered});

  @override
  List<Object?> get props => [
        updated,
        cases,
        todayCases,
        todayDeaths,
        deaths,
        todayRecovered,
        recovered
      ];

  DateTime get updatedTime => DateTime.fromMillisecondsSinceEpoch(updated * 1000);
}
