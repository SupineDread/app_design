import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authenticationAPI = GetIt.instance<AuthenticationAPI>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';

  Future<void> _submit() async {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      ProgressDialog.show(context);
      final response = await _authenticationAPI.login(email: _email, password: _password);
      ProgressDialog.dissmis(context);
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data);
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false);
      } else {
        String message = response.error.message;
        if (response.error.statusCode == -1) {
          message = "Bad network";
        } else if (response.error.statusCode == 403) {
          message = "Invalid password";
        } else if (response.error.statusCode == 404) {
          message = "User not found";
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
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InputText(
                        obscureText: true,
                        borderEnabled: false,
                        label: "PASSWORD",
                        fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        onChanged: (text) {
                          _password = text;
                        },
                        validator: (text) {
                          if (text.trim().length == 0) {
                            return "Invalid Password";
                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 10),
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15.0))),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                            color: Colors.black45),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15.0)),
                      backgroundColor: MaterialStateProperty.all(Colors.pinkAccent)),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  onPressed: this._submit,
                ),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "New to Friendly Design?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
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
