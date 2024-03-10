// ignore_for_file: one_member_abstracts

import 'package:advanced_exercise_finder_flutter_case/core/service/api_response_model.dart';

abstract class ApiService {
  Future<ApiResponse<T>> getRequest<T>(String path, {Map<String, dynamic>? queryParameters});
}
