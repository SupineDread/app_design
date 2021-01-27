import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/models/user.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _accountApi = GetIt.instance<AccountApi>();
  User _user;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountApi.getUserInfo();
    if (response.data != null) {
      _user = response.data;
      setState(() {});
    }
  }

  Future<void> _signOut() async {
    await _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_user == null) CircularProgressIndicator(),
          if (_user != null)
            Column(
              children: [
                Text(_user.id),
                Text(_user.email),
                Text(_user.username),
                Text(_user.createdAt.toIso8601String()),
              ],
            ),
          FlatButton(
            onPressed: _signOut,
            child: Text("Sign Out"),
          )
        ],
      ),
    ));
  }
}
