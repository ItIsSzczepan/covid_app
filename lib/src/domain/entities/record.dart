import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class Record extends Equatable {
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;

  const Record(
      {required this.newConfirmed,
      required this.totalConfirmed,
      required this.newDeaths,
      required this.totalDeaths,
      required this.newRecovered,
      required this.totalRecovered});

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  @override
  List<Object?> get props => [
        newConfirmed,
        totalConfirmed,
        newDeaths,
        totalDeaths,
        newRecovered,
        totalRecovered
      ];

}
