import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:advanced_exercise_finder_flutter_case/core/components/page_skeleton.dart';
import 'package:advanced_exercise_finder_flutter_case/core/constants/string_constants.dart';
import 'package:advanced_exercise_finder_flutter_case/core/enums/app_pages_enums.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/model/program_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/viewmodel/program_viewmodel.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/widgets/create_program_dialog.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/widgets/program_card.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/widgets/program_exercise_card.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/widgets/program_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgramView extends StatelessWidget {
  const ProgramView({super.key});

  Future<void> showCreateProgramDialog(BuildContext context, {ProgramModel? programModel}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '-',
      pageBuilder: (context, animation, secondaryAnimation) {
        return CreateProgramDialog(
          programModel: programModel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageSkeleton(
          title: AppPages.myProgram.getTitle(),
          headerMinHeight: 0,
          headerMaxHeight: 32,
          headerChild: programsBuilder(),
          slivers: [
            programExercisesBuilder(),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 32,
          child: programFabButtons(),
        ),
      ],
    );
  }

  Consumer<ProgramViewModel> programFabButtons() {
    return Consumer<ProgramViewModel>(
      builder: (context, programViewModel, _) {
        if (programViewModel.myPrograms.isEmpty) return const SizedBox();

        return Column(
          children: [
            ProgramFloatingButton(
              iconData: Icons.edit,
              onPressed: () {
                showCreateProgramDialog(
                  context,
                  programModel: programViewModel.myPrograms[programViewModel.activeProgramIndex],
                );
              },
            ),
            const SizedBox(height: 16),
            ProgramFloatingButton(
              iconData: Icons.add,
              onPressed: () {
                showCreateProgramDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  Consumer<ProgramViewModel> programsBuilder() {
    return Consumer<ProgramViewModel>(
      builder: (context, programViewModel, _) {
        if (programViewModel.myPrograms.isEmpty) return const SizedBox();

        final programs = programViewModel.myPrograms;

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProgramCard(
              index: index,
              programModel: programs[index],
              programViewModel: programViewModel,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemCount: programs.length,
        );
      },
    );
  }

  SliverToBoxAdapter programExercisesBuilder() {
    return SliverToBoxAdapter(
      child: Consumer<ProgramViewModel>(
        builder: (context, programViewModel, _) {
          if (programViewModel.myPrograms.isEmpty) {
            return TextButton.icon(
              onPressed: () {
                showCreateProgramDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const AppText(text: StringConstants.createProgramText),
            );
          }

          final exercises = programViewModel.myPrograms[programViewModel.activeProgramIndex].exercises!;

          return ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {
              programViewModel.updateExercisesOrder(oldIndex, newIndex);
            },
            itemCount: exercises.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final exercise = exercises[index];

              return ProgramExerciseCard(
                key: ValueKey(index),
                programViewModel: programViewModel,
                exercise: exercise,
              );
            },
          );
        },
      ),
    );
  }
}
