import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Column(
          children: <Widget>[
            InputText(
              keyboardType: TextInputType.emailAddress,
              label: "EMAIL ADDRESS",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
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
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                      ),
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
              child: FlatButton(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                onPressed: () {},
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
                  "New to Friendly Design?",
                  style: TextStyle(
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: responsive.dp(10),
            ),
          ],
        ),
      ),
    );
  }
}
