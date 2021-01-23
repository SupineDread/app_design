import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authenticationAPI = GetIt.instance<AuthenticationAPI>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';

  Logger _logger = Logger();

  Future<void> _submit() async {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      ProgressDialog.show(context);
      final response = await _authenticationAPI.register(
        username: _username,
        email: _email,
        password: _password,
      );
      ProgressDialog.dissmis(context);
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data);
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false);
      } else {
        String message = response.error.message;
        if (response.error.statusCode == -1) {
          message = "Bad network";
        } else if (response.error.statusCode == 409) {
          message = "Duplicated data ${jsonEncode(response.error.data['duplicatedFields'])}";
        }
        Dialogs.alert(context, title: "Error", description: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "USERNAME",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text.trim().length < 5) {
                    return "Invalid Username";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (!text.contains("@")) {
                    return "Invalid Email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              InputText(
                label: "PASSWORD",
                obscureText: true,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text.trim().length < 6) {
                    return "Invalid Password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  onPressed: this._submit,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already Have An Account?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: responsive.dp(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
