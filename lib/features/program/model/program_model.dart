import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'program_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class ProgramModel extends HiveObject {
  ProgramModel({
    required this.programId,
    required this.programName,
    required this.exercises,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) => _$ProgramModelFromJson(json);
  @JsonKey(name: 'programId')
  @HiveField(1)
  final int? programId;
  @JsonKey(name: 'programName')
  @HiveField(2)
  final String? programName;
  @JsonKey(name: 'exercises')
  @HiveField(3)
  final List<Exercises>? exercises;

  Map<String, dynamic> toJson() => _$ProgramModelToJson(this);

  ProgramModel copyWith({
    int? programId,
    String? programName,
    List<Exercises>? exercises,
  }) {
    return ProgramModel(
      programId: programId ?? this.programId,
      programName: programName ?? this.programName,
      exercises: exercises ?? this.exercises,
    );
  }
}
