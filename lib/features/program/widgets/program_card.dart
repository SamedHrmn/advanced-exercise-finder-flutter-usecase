import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/model/program_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/viewmodel/program_viewmodel.dart';
import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({required this.programViewModel, required this.programModel, required this.index, super.key});

  final ProgramViewModel programViewModel;
  final ProgramModel programModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final selected = programViewModel.activeProgramIndex == index;

    return InkWell(
      onTap: () => programViewModel.updateActiveProgramIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selected ? Colors.purple : Colors.grey.shade300,
        ),
        child: FittedBox(
          child: AppText(text: programModel.programName!, color: selected ? Colors.white : null),
        ),
      ),
    );
  }
}
