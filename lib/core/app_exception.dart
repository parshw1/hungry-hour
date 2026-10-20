class AppException implements Exception {
  const AppException(
    this.code,
    this.message, {
    this.fields,
    this.statusCode,
  });
 
  final String code;
  final String message;
  final Map<String, String>? fields; // only for validation errors
  final int? statusCode;
 
  factory AppException.fromErrorJson(Map<String, dynamic> json, {int? statusCode}) {
    final error = (json['error'] ?? json) as Map<String, dynamic>;
    final rawFields = error['fields'] as Map<String, dynamic>?;
    return AppException(
      error['code'] as String? ?? 'unknown',
      error['message'] as String? ?? 'Something went wrong',
      fields: rawFields?.map((k, v) => MapEntry(k, v.toString())),
      statusCode: statusCode,
    );
  }
 
  @override
  String toString() => 'AppException($code): $message';
}
 