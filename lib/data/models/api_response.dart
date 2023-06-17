import '../../app/app_typedefs.dart';

class ApiResponse {
  final bool success;
  final JsonMap data;

  ApiResponse({
    required this.success,
    required this.data,
  });

  @override
  String toString() => "${super.toString()}, success: $success, data: $data";
}
