import 'package:common/network/model/error_response.dart';

class ApiException implements Exception {
  ErrorResponse errorResponse;

  ApiException(this.errorResponse);
}
