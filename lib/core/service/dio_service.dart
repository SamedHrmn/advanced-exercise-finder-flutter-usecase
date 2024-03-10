import 'package:advanced_exercise_finder_flutter_case/core/service/api_response_model.dart';
import 'package:advanced_exercise_finder_flutter_case/core/service/api_service.dart';
import 'package:dio/dio.dart';

class DioService implements ApiService {
  DioService(this._dio);
  final Dio _dio;

  @override
  Future<ApiResponse<T>> getRequest<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get<dynamic>(path, queryParameters: queryParameters);
      return ApiResponse<T>(response.data as T, null);
    } catch (e) {
      return ApiResponse(null, e.toString());
    }
  }
}
