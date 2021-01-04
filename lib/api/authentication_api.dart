import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_api_rest/helpers/http_helpers.dart';
import 'package:meta/meta.dart' show required;

class AuthenticationAPI {
  final Http _http;

  AuthenticationAPI(this._http);

  Future<HttpResponse> register({@required String username, @required String email, @required String password}) {
    return _http.request(
      '/api/v1/register',
      method: "POST",
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
    );
  }

  Future<HttpResponse> login({@required String email, @required String password}) async {
    return _http.request(
      '/api/v1/login',
      method: "POST",
      data: {
        "email": email,
        "password": password,
      },
    );
  }
}
