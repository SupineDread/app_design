import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_api_rest/helpers/http_helpers.dart';
import 'package:flutter_api_rest/models/authentication_response.dart';
import 'package:meta/meta.dart' show required;

class AuthenticationAPI {
  final Http _http;

  AuthenticationAPI(this._http);

  Future<HttpResponse<AuthenticationResponse>> register(
      {@required String username, @required String email, @required String password}) {
    return _http.request<AuthenticationResponse>(
      '/api/v1/register',
      method: "POST",
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AuthenticationResponse>> login({@required String email, @required String password}) async {
    return _http.request<AuthenticationResponse>(
      '/api/v1/login',
      method: "POST",
      data: {
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }
}
