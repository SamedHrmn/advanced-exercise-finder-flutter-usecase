// ignore_for_file: parameter_assignments

import 'dart:async';

import 'package:advanced_exercise_finder_flutter_case/core/cache/app_cache_manager.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/model/program_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCacheManager extends AppCacheManager {
  Box<dynamic>? hiveBox;

  Future<void> initHiveManager() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(ExercisesAdapter())
      ..registerAdapter(ProgramModelAdapter());
    hiveBox = await Hive.openBox('programs');
  }

  Future<void> clear() async {
    if (hiveBox!.isOpen) {
      await hiveBox!.clear();
    }
  }

  Future<void> add(ProgramModel programModel) async {
    if (hiveBox == null) return;

    final id = await hiveBox!.add(programModel);
    programModel = programModel.copyWith(programId: id);
    unawaited(hiveBox!.put(id, programModel));
  }

  bool isInBox<T extends HiveObject>(T object) {
    if (hiveBox == null) return false;

    return object.isInBox;
  }

  void delete<T extends HiveObject>(T object) {
    if (hiveBox == null) return;

    try {
      if (object.isInBox) {
        object.delete();
      }
    } catch (e) {
      hiveBox!.flush();
    }
  }

  List<ProgramModel> get<ProgramModel>() {
    if (hiveBox == null) return <ProgramModel>[];

    return hiveBox!.values.toList().cast<ProgramModel>();
  }

  void update(ProgramModel programModel) {
    if (hiveBox == null) return;
    hiveBox!.put(programModel.programId, programModel);
  }
}
