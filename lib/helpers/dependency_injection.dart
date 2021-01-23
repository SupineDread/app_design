import 'package:dio/dio.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(BaseOptions(baseUrl: 'https://evening-refuge-79635.herokuapp.com'));
    Logger logger = Logger();
    Http http = Http(dio: dio, logger: logger, logsEnabled: true);

    final FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final AuthenticationAPI authenticationAPI = AuthenticationAPI(http);
    final AuthenticationClient authenticationClient = AuthenticationClient(secureStorage);

    GetIt.instance.registerSingleton<AuthenticationAPI>(authenticationAPI);
    GetIt.instance.registerSingleton<AuthenticationClient>(authenticationClient);
  }
}
