import 'package:dio/dio.dart';
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(BaseOptions(baseUrl: 'https://evening-refuge-79635.herokuapp.com'));
    Http http = Http(dio: dio, logsEnabled: true);

    final FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final AuthenticationAPI authenticationAPI = AuthenticationAPI(http);
    final AuthenticationClient authenticationClient = AuthenticationClient(secureStorage);
    final AccountApi accountApi = AccountApi(http, authenticationClient);

    GetIt.instance.registerSingleton<AuthenticationAPI>(authenticationAPI);
    GetIt.instance.registerSingleton<AuthenticationClient>(authenticationClient);
    GetIt.instance.registerSingleton<AccountApi>(accountApi);
  }
}
