import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/viewmodel/program_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProgramExerciseCard extends StatelessWidget {
  const ProgramExerciseCard({required this.programViewModel, required this.exercise, super.key});

  final ProgramViewModel programViewModel;
  final Exercises exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(16),
              backgroundColor: Colors.red,
              onPressed: (_) {
                programViewModel.deleteExercise(exercise);
              },
            ),
          ],
        ),
        child: Container(
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
                  AppText(text: exercise.name),
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
                child: AppText(text: exercise.type),
              ),
              AppText(text: exercise.muscle),
            ],
          ),
        ),
      ),
    );
  }
}
