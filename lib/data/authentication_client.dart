import 'dart:convert';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/models/authentication_response.dart';
import 'package:flutter_api_rest/models/session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationClient {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationAPI _authenticationAPI;

  AuthenticationClient(this._secureStorage, this._authenticationAPI);

  Future<String> get accessToken async {
    final data = await _secureStorage.read(key: 'SESSION');
    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));

      final DateTime currentDate = DateTime.now();
      final DateTime createdAt = session.createdAt;
      final int expiresIn = session.expiresIn;
      final diff = currentDate.difference(createdAt).inSeconds;

      if (expiresIn - diff >= 60) {
        return session.token;
      }

      final response = await _authenticationAPI.refreshToken(session.token);
      if (response.data != null) {
        await this.saveSession(response.data);
        return response.data.token;
      }

      return null;
    }
    return null;
  }

  Future<void> saveSession(AuthenticationResponse authenticationResponse) async {
    final Session session = Session(
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createdAt: DateTime.now(),
    );
    final data = jsonEncode(session.toJson());
    await _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> signOut() async {
    await _secureStorage.deleteAll();
  }
}
