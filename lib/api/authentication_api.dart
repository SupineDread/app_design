import 'package:dio/dio.dart';
import 'package:flutter_api_rest/helpers/http_helpers.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart' show required;

class AuthenticationAPI {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<HttpResponse> register({@required String username, @required String email, @required String password}) async {
    try {
      final response = await _dio.post(
        'https://evening-refuge-79635.herokuapp.com/api/v1/register',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
      );
      _logger.i(response.data);
      return HttpResponse.success(response.data);
    } catch (e) {
      _logger.e(e);
      int statusCode = -1;
      String message = "Unknown error";
      dynamic data;
      if (e is DioError) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response.statusCode;
          message = e.response.statusMessage;
          data = e.response.data;
        }
      }
      return HttpResponse.fail(statusCode: statusCode, message: message, data: data);
    }
  }
}
