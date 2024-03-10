// ignore_for_file: avoid_print

import 'package:advanced_exercise_finder_flutter_case/core/enums/exercise_muscle_enums.dart';
import 'package:advanced_exercise_finder_flutter_case/core/service/api_response_model.dart';
import 'package:advanced_exercise_finder_flutter_case/core/service/dio_service.dart';
import 'package:advanced_exercise_finder_flutter_case/core/util/env_manager.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await EnvManager.init();
    FakeLocator.setup();
    await FakeLocator.getIt.getAsync<FakeDioService>();
  });

  test('Api test', () async {
    final service = FakeLocator.getIt<FakeDioService>();

    try {
      final response = await service.getRequest<List<dynamic>>(
        EnvManager.env.get('API_BASE_URL'),
        queryParameters: {'muscle': ExerciseMuscle.biceps.name},
      );

      print(response.data);
    } catch (e) {
      print(e);
    }
  });
}

class FakeDioService extends DioService {
  FakeDioService(this.dio) : super(dio);

  final Dio dio;

  @override
  Future<ApiResponse<T>> getRequest<T>(String path, {Map<String, dynamic>? queryParameters}) {
    return super.getRequest(path, queryParameters: queryParameters);
  }
}

class FakeLocator {
  FakeLocator._();

  static GetIt get getIt => _getIt;

  static final _getIt = GetIt.instance;

  static void setup() {
    _getIt.registerLazySingletonAsync<FakeDioService>(() async {
      final options = CacheOptions(
        store: HiveCacheStore('./'),
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 1),
      );

      final dio = Dio(
        BaseOptions(
          headers: {
            'X-Api-Key': EnvManager.env.get('RAPID_API_KEY'),
          },
        ),
      )
        ..interceptors.add(DioCacheInterceptor(options: options))
        ..interceptors.add(LogInterceptor(responseBody: true));
      return FakeDioService(dio);
    });
  }
}
