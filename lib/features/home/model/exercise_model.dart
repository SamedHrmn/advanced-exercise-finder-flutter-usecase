// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_equals_and_hash_code_on_mutable_classes
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Exercises extends HiveObject {
  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;
  @HiveField(2)
  @JsonKey(name: 'type')
  final String type;
  @HiveField(3)
  @JsonKey(name: 'muscle')
  final String muscle;
  @HiveField(4)
  @JsonKey(name: 'equipment')
  final String equipment;
  @HiveField(5)
  @JsonKey(name: 'difficulty')
  final String difficulty;
  @HiveField(6)
  @JsonKey(name: 'instructions')
  final String instructions;

  Exercises({
    required this.name,
    required this.type,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  factory Exercises.fromJson(Map<String, dynamic> json) => _$ExercisesFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesToJson(this);

  @override
  bool operator ==(covariant Exercises other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.muscle == muscle &&
        other.equipment == equipment &&
        other.difficulty == difficulty &&
        other.instructions == instructions;
  }

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ muscle.hashCode ^ equipment.hashCode ^ difficulty.hashCode ^ instructions.hashCode;
  }
}
