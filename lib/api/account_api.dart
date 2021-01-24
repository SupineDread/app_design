import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_api_rest/helpers/http_helpers.dart';
import 'package:flutter_api_rest/models/user.dart';

class AccountApi {
  final Http _http;
  final AuthenticationClient _authenticationClient;

  AccountApi(this._http, this._authenticationClient);

  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken;
    return _http.request<User>(
      '/api/v1/user-info',
      method: "GET",
      headers: {"token": token},
      parser: (data) {
        return User.fromJson(data);
      },
    );
  }
}
