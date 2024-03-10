class ApiResponse<T> {
  ApiResponse(this.data, this.error);
  final T? data;
  final String? error;
}
