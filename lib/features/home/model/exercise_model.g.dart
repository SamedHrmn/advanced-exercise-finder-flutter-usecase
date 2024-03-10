// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExercisesAdapter extends TypeAdapter<Exercises> {
  @override
  final int typeId = 1;

  @override
  Exercises read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercises(
      name: fields[1] as String,
      type: fields[2] as String,
      muscle: fields[3] as String,
      equipment: fields[4] as String,
      difficulty: fields[5] as String,
      instructions: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Exercises obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.muscle)
      ..writeByte(4)
      ..write(obj.equipment)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.instructions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExercisesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercises _$ExercisesFromJson(Map<String, dynamic> json) => Exercises(
      name: json['name'] as String,
      type: json['type'] as String,
      muscle: json['muscle'] as String,
      equipment: json['equipment'] as String,
      difficulty: json['difficulty'] as String,
      instructions: json['instructions'] as String,
    );

Map<String, dynamic> _$ExercisesToJson(Exercises instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'muscle': instance.muscle,
      'equipment': instance.equipment,
      'difficulty': instance.difficulty,
      'instructions': instance.instructions,
    };
