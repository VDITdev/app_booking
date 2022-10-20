import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:app_booking/amplifyconfiguration.dart';
import 'package:app_booking/utils/route/router.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

// class _MyAppState extends State<MyApp> {
//   bool _amplifyconfigured = false;
//   @override
//   void initState() {
//     super.initState();
//     _configureAmplify();
//   }

// print("--WelcomeSession:-- ${state.status}");

class _OnboardScreenState extends State<OnboardScreen> {
  bool _amplifyconfigured = false;
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return _sceneBuilder();
  }

  Widget _sceneBuilder() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "VDIT",
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              minWidth: 200,
              color: Colors.lightBlueAccent,
              child: const Text("Login"),
              onPressed: () {
                Navigator.pushNamed(context, SIGNIN_ROUTE);
              },
            ),
            MaterialButton(
              minWidth: 200,
              color: Colors.lightBlueAccent,
              child: const Text("Register"),
              onPressed: () {
                Navigator.pushNamed(context, SIGNUP_ROUTE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
