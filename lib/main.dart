import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/helpers/dependency_injection.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter_api_rest/pages/register_page.dart';
import 'package:flutter_api_rest/pages/splash_page.dart';

void main() {
  DependencyInjection.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        RegisterPage.routeName: (BuildContext context) => RegisterPage(),
        LoginPage.routeName: (BuildContext context) => LoginPage(),
        HomePage.routeName: (BuildContext context) => HomePage(),
      },
    );
  }
}
