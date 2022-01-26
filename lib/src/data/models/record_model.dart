import 'package:covid_app/src/domain/entities/record.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record_model.g.dart';

@JsonSerializable()
class RecordModel extends Record {
  const RecordModel(
      {required int todayCases,
        required int cases,
        required int todayDeaths,
        required int deaths,
        required int todayRecovered,
        required int recovered})
      : super(
            cases: cases,
            todayCases: todayCases,
            todayDeaths: todayDeaths,
            deaths: deaths,
            todayRecovered: todayRecovered,
            recovered: recovered);

  factory RecordModel.fromJson(Map<String, dynamic> json) => _$RecordModelFromJson(json);
}
