class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final dynamic rawData;

  ApiResponse({required this.success, this.data, this.rawData, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic)? fromJson) {
    return ApiResponse<T>(
      success: json['success'] ?? true,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJson!(json['data']) : json['data'],
      rawData: json,
    );
  }

  factory ApiResponse.fromList(List<dynamic> jsonList, T Function(dynamic) fromJson) {
    return ApiResponse<T>(
      success: true,
      message: '',
      data: fromJson(jsonList),
      rawData: jsonList,
    );
  }

  factory ApiResponse.fromData(dynamic data, T Function(dynamic)? fromJson) {
    if (data is List) {
      return ApiResponse.fromList(data, fromJson!);
    } else if (data is Map<String, dynamic>) {
      return ApiResponse.fromJson(data, fromJson);
    } else {
      return ApiResponse<T>(success: true, message: '', data: fromJson!(data), rawData: data);
    }
  }
}
