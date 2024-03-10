import 'package:advanced_exercise_finder_flutter_case/core/cache/app_path_provider.dart';
import 'package:advanced_exercise_finder_flutter_case/core/cache/hive_cache_manager.dart';
import 'package:advanced_exercise_finder_flutter_case/core/components/app_navbar.dart';
import 'package:advanced_exercise_finder_flutter_case/core/service/dio_service.dart';
import 'package:advanced_exercise_finder_flutter_case/core/util/env_manager.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/view/home_view.dart';
import 'package:advanced_exercise_finder_flutter_case/features/home/viewmodel/homeview_viewmodel.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/view/program_view.dart';
import 'package:advanced_exercise_finder_flutter_case/features/program/viewmodel/program_viewmodel.dart';
import 'package:advanced_exercise_finder_flutter_case/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Setup dependencies and environments.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvManager.init();
  await AppPathProvider.initPath();
  setupDependencies();
  await Future.wait([
    locator.getAsync<DioService>(),
    locator.get<HiveCacheManager>().initHiveManager(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewViewModel(
            apiService: locator.get<DioService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProgramViewModel(
            hiveCacheManager: locator.get<HiveCacheManager>(),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppView(),
      ),
    );
  }
}

/// [AppView] is a skeleton widget for entire application
class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavBar(
        pageController: pageController,
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeView(),
            ProgramView(),
          ],
        ),
      ),
    );
  }
}
