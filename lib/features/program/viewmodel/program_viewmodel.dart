import 'package:advanced_exercise_finder_flutter_case/core/cache/hive_cache_manager.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/model/program_model.dart';
import 'package:flutter/foundation.dart';

class ProgramViewModel extends ChangeNotifier {
  ProgramViewModel({required this.hiveCacheManager}) {
    getPrograms();
  }
  List<ProgramModel> _myPrograms = [];
  List<ProgramModel> get myPrograms => _myPrograms;

  final HiveCacheManager hiveCacheManager;
  int _activeProgramIndex = 0;
  int get activeProgramIndex => _activeProgramIndex;

  /// Updating current program list in ui
  void updateActiveProgramIndex(int i) {
    _activeProgramIndex = i;
    notifyListeners();
  }

  /// Create a exercise program. If [programName] does not provided it will be set as "Program0"
  /// [exercises] must be fill.
  void createProgram({required String? programName, required List<Exercises> exercises}) {
    final model = ProgramModel(programId: null, programName: programName ?? 'Program0', exercises: exercises);

    _myPrograms.add(model);
    hiveCacheManager.add(model);

    notifyListeners();
  }

  /// Update current program [programName] or [exercises]
  void updateProgram({required String? programName, required List<Exercises> exercises, required ProgramModel programModel}) {
    programModel = programModel.copyWith(programName: programName, exercises: exercises);
    _myPrograms[_myPrograms.indexWhere((element) => element.programId == programModel.programId)] = programModel;
    hiveCacheManager.update(programModel);
    notifyListeners();
  }

  /// Fetch all programs from local database initially
  void getPrograms() {
    _myPrograms = hiveCacheManager.get();
    notifyListeners();
  }

  /// Delete selected exercise from selected program
  void deleteExercise(Exercises exercise) {
    myPrograms[activeProgramIndex].exercises!.remove(exercise);
    if (myPrograms[activeProgramIndex].exercises!.isEmpty) {
      final deletedModel = _myPrograms.removeAt(activeProgramIndex);
      hiveCacheManager.delete(deletedModel);
    }
    notifyListeners();
  }

  /// Change selected exercise list order
  void updateExercisesOrder(int oldIndex, int newIndex) {
    final exercises = myPrograms[activeProgramIndex].exercises!;
    final i = exercises[oldIndex];
    exercises[oldIndex] = exercises[newIndex];
    exercises[newIndex] = i;
    myPrograms[activeProgramIndex] = myPrograms[activeProgramIndex].copyWith(exercises: exercises);
    hiveCacheManager.update(myPrograms[activeProgramIndex]);
    notifyListeners();
  }
}
