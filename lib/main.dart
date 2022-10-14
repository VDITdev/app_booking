import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              GestureDetector(
                onTap: () {
                  signUpUser();
                  print(isSignUpComplete);
                },
                child: Text("Sign Up"),
              ),
              GestureDetector(
                onTap: () {
                  confirmUser();
                },
                child: Text("Confirm"),
              ),
              GestureDetector(
                onTap: () {
                  signInUser('test1', '123456');
                },
                child: Text("Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ------------------------------------------

  bool isSignUpComplete = false;

  Future<void> signUpUser() async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: 'tuan.nguyen@vdit.co.uk',
        CognitoUserAttributeKey.phoneNumber: '+447123456789',
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: 'test1',
        password: '123456',
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      setState(() {
        isSignUpComplete = result.isSignUpComplete;
      });
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> confirmUser() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: 'test1', confirmationCode: '566231');

      setState(() {
        isSignUpComplete = result.isSignUpComplete;
      });
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }


// ------------------------------------------

bool isSignedIn = false;

Future<void> signInUser(String username, String password) async {
  try {
    final result = await Amplify.Auth.signIn(
      username: username,
      password: password,
    );

    setState(() {
      isSignedIn = result.isSignedIn;
    });

  } on AuthException catch (e) {
    safePrint(e.message);
  }
}

}
