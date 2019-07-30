import 'package:flutter/material.dart';
import 'package:sign_in_flutter/sign_in.dart';
import 'package:sign_in_flutter/first_screen.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(size: 150),
                  SizedBox(height: 50),
                  _googleSignInButton(),
                  SizedBox(height: 50),
//                  _facebookSignInButton()
                ],
              )),
        ));
  }

  Widget _googleSignInButton() {
    return GoogleSignInButton(
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FirstScreen();
              },
            ),
          );
        });
      },
      darkMode: true, // default: false
    );
  }

//  Widget _facebookSignInButton() {
//    return FacebookSignInButton(onPressed: () {
//      onPressed: () {
//        signInWithFacebook1().whenComplete(() {
//          Navigator.of(context).push(
//            MaterialPageRoute(
//              builder: (context) {
//                return FirstScreen();
//              },
//            ),
//          );
//        });
//      };
//    });
//  }
}
