import 'package:advanced_exercise_finder_flutter_case/core/constants/string_constants.dart';
import 'package:advanced_exercise_finder_flutter_case/core/enums/exercise_muscle_enums.dart';
import 'package:advanced_exercise_finder_flutter_case/core/enums/exercise_type_enums.dart';
import 'package:advanced_exercise_finder_flutter_case/core/service/api_service.dart';
import 'package:advanced_exercise_finder_flutter_case/core/util/debouncer.dart';
import 'package:advanced_exercise_finder_flutter_case/core/util/env_manager.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/viewmodel/home_exercises_state.dart';
import 'package:flutter/foundation.dart';

class HomeViewViewModel extends ChangeNotifier {
  HomeViewViewModel({required this.apiService});
  final ApiService apiService;

  HomeExercisesState _homeExercisesState = HomeExercisesState(fetchStatus: HomeExerciseFetchStatus.initial);
  HomeExercisesState get homeExercisesState => _homeExercisesState;
  final debouncer = Debouncer(milliseconds: 500);
  String? _searchExerciseName;
  String? get searchExerciseName => _searchExerciseName;
  final List<ExerciseMuscle> _filterExerciseMuscles = [];
  List<ExerciseMuscle> get filterExerciseMuscles => _filterExerciseMuscles;
  ExerciseType? _filterExerciseType;
  ExerciseType? get filterExerciseType => _filterExerciseType;

  /// Clear all selected filters and exercises.
  void clearAllFilters() {
    _filterExerciseMuscles.clear();
    _filterExerciseType = null;
    _homeExercisesState = HomeExercisesState.initial();
    notifyListeners();
  }

  /// Update selected exercise type filter value.
  void updateFilterExerciseType(ExerciseType? exerciseType) {
    if (_filterExerciseType == exerciseType && _filterExerciseType != null) {
      _filterExerciseType = null;
      notifyListeners();
      return;
    }

    _filterExerciseType = exerciseType;
    notifyListeners();
  }

  /// Update selected exercise muscles filter values.
  /// It can support multi selection but only first item will be effect.
  void updateFilterExerciseMuscles(ExerciseMuscle muscle) {
    if (_filterExerciseMuscles.isEmpty || !_filterExerciseMuscles.contains(muscle)) {
      _filterExerciseMuscles.add(muscle);
    } else {
      _filterExerciseMuscles.remove(muscle);
    }

    notifyListeners();
  }

  /// Update exercise name search filter value.
  void updateSearchExerciseName(String? v) {
    _searchExerciseName = v;
    notifyListeners();
  }

  /// Update home data state.
  void updateHomeExercisesState(HomeExercisesState state) {
    _homeExercisesState = state;
    notifyListeners();
  }

  /// This function get exercise list according to [exerciseName],
  /// [muscle] if selected any or [exerciseType] if selected any.
  /// Exercise list can be accessable in [HomeExercisesState] if [HomeExerciseFetchStatus.success] is true
  Future<void> _getExercises({
    String? exerciseName,
    ExerciseMuscle? muscle,
    ExerciseType? exerciseType,
  }) async {
    updateHomeExercisesState(HomeExercisesState.loading());

    final queries = <String, dynamic>{};

    if (exerciseName != null && exerciseName.isNotEmpty) {
      queries['name'] = exerciseName.toLowerCase().trim();
    }

    if (muscle != null) {
      queries['muscle'] = muscle.name;
    }

    if (exerciseType != null) {
      queries['type'] = exerciseType.name;
    }

    final response = await apiService.getRequest<List<dynamic>>(
      EnvManager.env.get('API_BASE_URL'),
      queryParameters: queries,
    );

    if (response.data == null) {
      updateHomeExercisesState(HomeExercisesState.failure(error: StringConstants.errorText));
      return;
    }

    final exerciseList = <Exercises>[];
    for (final element in response.data!) {
      exerciseList.add(Exercises.fromJson(element as Map<String, dynamic>));
    }

    updateHomeExercisesState(HomeExercisesState.success(exercises: exerciseList));
  }

  /// Fetch exercises according to its name
  void getExercisesByName(String? name) {
    if (name == null || name.isEmpty == true) return;

    debouncer.run(() {
      _getExercises(exerciseName: name);
    });
  }

  /// Fetch exercises according to muscle or type filtering.
  void getExerciseByMuscleOrType() {
    if (filterExerciseMuscles.isEmpty && filterExerciseType == null) return;

    debouncer.run(() {
      _getExercises(
        exerciseName: searchExerciseName,
        exerciseType: filterExerciseType,
        muscle: filterExerciseMuscles.isEmpty ? null : filterExerciseMuscles.first,
      );
    });
  }
}
