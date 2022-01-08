import 'package:covid_app/src/domain/entities/record.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record_model.g.dart';

@JsonSerializable()
class RecordModel extends Record {
  const RecordModel(newConfirmed, totalConfirmed, newDeaths, totalDeaths,
      newRecovered, totalRecovered)
      : super(
            newConfirmed: newConfirmed,
            totalConfirmed: totalConfirmed,
            newDeaths: newDeaths,
            totalDeaths: totalDeaths,
            newRecovered: newRecovered,
            totalRecovered: totalRecovered);

  factory RecordModel.fromJson(Map<String, dynamic> json) => _$RecordModelFromJson(json);
}
