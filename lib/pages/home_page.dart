import 'package:flutter/material.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

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
          FlatButton(
            onPressed: _signOut,
            child: Text("Sign Out"),
          )
        ],
      ),
    ));
  }
}
