import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:advanced_exercise_finder_flutter_case/core/constants/string_constants.dart';
import 'package:advanced_exercise_finder_flutter_case/core/enums/exercise_muscle_enums.dart';
import 'package:advanced_exercise_finder_flutter_case/core/enums/exercise_type_enums.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/viewmodel/homeview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseFilterSheet extends StatelessWidget {
  const ExerciseFilterSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewViewModel = context.watch<HomeViewViewModel>();

    return BottomSheet(
      onClosing: () {},
      enableDrag: false,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(text: StringConstants.musclesText),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: ExerciseMuscle.values
                    .map(
                      (e) => Material(
                        color: homeViewViewModel.filterExerciseMuscles.contains(e) ? Colors.purple : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () {
                            homeViewViewModel.updateFilterExerciseMuscles(e);
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: AppText(text: e.name),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 24,
              ),
              const AppText(text: StringConstants.typeText),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: ExerciseType.values
                    .map(
                      (e) => Material(
                        color: homeViewViewModel.filterExerciseType == e ? Colors.purple : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () {
                            homeViewViewModel.updateFilterExerciseType(e);
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: AppText(text: e.name),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
