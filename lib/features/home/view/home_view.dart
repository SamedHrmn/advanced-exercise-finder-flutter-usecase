import 'package:advanced_exercise_finder_flutter_case/core/components/app_progress_indicator.dart';
import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:advanced_exercise_finder_flutter_case/core/components/page_skeleton.dart';
import 'package:advanced_exercise_finder_flutter_case/core/constants/string_constants.dart';
import 'package:advanced_exercise_finder_flutter_case/core/enums/app_pages_enums.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/viewmodel/home_exercises_state.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/viewmodel/homeview_viewmodel.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/widgets/exercise_filter_sheet.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/widgets/home_exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      title: AppPages.home.getTitle(),
      headerMinHeight: 0,
      headerMaxHeight: 100,
      actions: [
        clearFilterButtonBuilder(),
      ],
      headerChild: exerciseSearchFilterHeader(context),
      slivers: [
        exerciseListBuilder(),
      ],
    );
  }

  SliverToBoxAdapter exerciseListBuilder() {
    return SliverToBoxAdapter(
      child: Consumer<HomeViewViewModel>(
        builder: (context, homeViewViewModel, _) {
          switch (homeViewViewModel.homeExercisesState.fetchStatus) {
            case HomeExerciseFetchStatus.initial:
              return const Center(child: AppText(text: StringConstants.searchHintText));
            case HomeExerciseFetchStatus.loading:
              return const AppProgressIndicator();
            case HomeExerciseFetchStatus.failure:
              return AppText(text: homeViewViewModel.homeExercisesState.error ?? StringConstants.errorText);
            case HomeExerciseFetchStatus.success:
              final items = homeViewViewModel.homeExercisesState.exercises!;

              return Column(
                children: [
                  const SizedBox(height: 16),
                  AppText(text: StringConstants.xResultFound.replaceFirst('x', items.length.toString())),
                  ListView.separated(
                    itemCount: items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return HomeExerciseCard(
                        exerciseModel: items[index],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  Container exerciseSearchFilterHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 2,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                context.read<HomeViewViewModel>().updateSearchExerciseName(value);
                context.read<HomeViewViewModel>().getExercisesByName(value);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (context) {
                  return const ExerciseFilterSheet();
                },
              ).then((_) {
                context.read<HomeViewViewModel>().getExerciseByMuscleOrType();
              });
            },
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
    );
  }

  Consumer<HomeViewViewModel> clearFilterButtonBuilder() {
    return Consumer<HomeViewViewModel>(
      builder: (context, homeViewViewModel, _) {
        if (homeViewViewModel.filterExerciseMuscles.isEmpty && homeViewViewModel.filterExerciseType == null) {
          return const SizedBox();
        }

        return TextButton.icon(
          onPressed: () {
            homeViewViewModel.clearAllFilters();
          },
          icon: const Icon(Icons.remove),
          label: const AppText(text: StringConstants.clearFiltersText),
        );
      },
    );
  }
}
