import 'package:advanced_exercise_finder_flutter_case/core/cache/app_path_provider.dart';
import 'package:advanced_exercise_finder_flutter_case/core/cache/hive_cache_manager.dart';
import 'package:advanced_exercise_finder_flutter_case/core/service/dio_service.dart';
import 'package:advanced_exercise_finder_flutter_case/core/util/env_manager.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator
    ..registerLazySingletonAsync<DioService>(() async {
      final options = CacheOptions(
        store: HiveCacheStore(AppPathProvider.path),
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 1),
      );

      final dio = Dio(BaseOptions(headers: {'X-Api-Key': EnvManager.env.get('RAPID_API_KEY')}))
        ..interceptors.add(DioCacheInterceptor(options: options))
        ..interceptors.add(LogInterceptor());

      return DioService(dio);
    })
    ..registerSingleton<HiveCacheManager>(HiveCacheManager());
}
