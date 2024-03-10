import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';

enum HomeExerciseFetchStatus { initial, loading, success, failure }

class HomeExercisesState {
  HomeExercisesState({required this.fetchStatus, this.error, this.exercises});
  factory HomeExercisesState.failure({required String error}) => HomeExercisesState(fetchStatus: HomeExerciseFetchStatus.failure, error: error);

  factory HomeExercisesState.initial() => HomeExercisesState(fetchStatus: HomeExerciseFetchStatus.initial);
  factory HomeExercisesState.loading() => HomeExercisesState(fetchStatus: HomeExerciseFetchStatus.loading);
  factory HomeExercisesState.success({required List<Exercises> exercises}) => HomeExercisesState(fetchStatus: HomeExerciseFetchStatus.success, exercises: exercises);
  final String? error;
  final List<Exercises>? exercises;
  final HomeExerciseFetchStatus fetchStatus;

  HomeExercisesState copyWith({
    String? error,
    List<Exercises>? exercises,
    HomeExerciseFetchStatus? fetchStatus,
  }) {
    return HomeExercisesState(
      error: error ?? this.error,
      exercises: exercises ?? this.exercises,
      fetchStatus: fetchStatus ?? this.fetchStatus,
    );
  }
}
