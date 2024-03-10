import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';
import 'package:flutter/material.dart';

class HomeExerciseCard extends StatelessWidget {
  const HomeExerciseCard({required this.exerciseModel, super.key});

  final Exercises exerciseModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 2, blurRadius: 4),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppText(text: exerciseModel.name),
              const Spacer(),
              IconButton.filled(
                style: IconButton.styleFrom(
                  fixedSize: const Size(24, 24),
                  minimumSize: Size.zero,
                  iconSize: 16,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.shade300),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: AppText(text: exerciseModel.type),
          ),
          AppText(text: exerciseModel.muscle),
        ],
      ),
    );
  }
}
