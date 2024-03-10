import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:advanced_exercise_finder_flutter_case/core/constants/string_constants.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/model/exercise_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/viewmodel/home_exercises_state.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/viewmodel/homeview_viewmodel.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/model/program_model.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/viewmodel/program_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProgramDialog extends StatefulWidget {
  const CreateProgramDialog({
    super.key,
    this.programModel,
  });

  final ProgramModel? programModel;

  @override
  State<CreateProgramDialog> createState() => _CreateProgramDialogState();
}

class _CreateProgramDialogState extends State<CreateProgramDialog> {
  List<Exercises> programs = [];
  String? programName;
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.programModel != null) {
      programName = widget.programModel!.programName;
      programs = widget.programModel!.exercises!;
      textEditingController.text = programName ?? '';
    }

    Future.microtask(() {
      final exercises = context.read<HomeViewViewModel>().homeExercisesState.exercises;

      if (exercises == null || exercises.isEmpty == true) {
        context.read<HomeViewViewModel>().getExercisesByName('D');
      }
    });
  }

  void updateProgramName(String? v) {
    setState(() {
      programName = v;
    });
  }

  void updatePrograms(Exercises exercises) {
    setState(() {
      if (programs.contains(exercises)) {
        programs.remove(exercises);
      } else {
        programs.add(exercises);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 420,
        width: double.maxFinite,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: TextField(
                controller: textEditingController,
                onChanged: updateProgramName,
                decoration: const InputDecoration(
                  labelText: StringConstants.programNameText,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: Consumer<HomeViewViewModel>(
                builder: (context, homeViewViewModel, _) {
                  switch (homeViewViewModel.homeExercisesState.fetchStatus) {
                    case HomeExerciseFetchStatus.initial:
                    case HomeExerciseFetchStatus.loading:
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    case HomeExerciseFetchStatus.failure:
                      return AppText(text: homeViewViewModel.homeExercisesState.error ?? StringConstants.errorText);
                    case HomeExerciseFetchStatus.success:
                      final items = homeViewViewModel.homeExercisesState.exercises!;

                      return ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(child: AppText(text: items[index].name)),
                              Checkbox(
                                value: programs.contains(items[index]),
                                onChanged: (value) {
                                  updatePrograms(items[index]);
                                },
                              ),
                            ],
                          );
                        },
                      );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogControlButton(
                    onPressed: () {
                      if (programs.isNotEmpty && widget.programModel == null) {
                        context.read<ProgramViewModel>().createProgram(programName: programName, exercises: programs);
                      } else if (programs.isNotEmpty && widget.programModel != null) {
                        context.read<ProgramViewModel>().updateProgram(programName: programName, exercises: programs, programModel: widget.programModel!);
                      }

                      Navigator.of(context).pop();
                    },
                    text: StringConstants.okayText,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogControlButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: StringConstants.cancelText,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogControlButton extends StatelessWidget {
  const _DialogControlButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: AppText(text: text));
  }
}
