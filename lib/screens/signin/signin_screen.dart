import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  AuthenticatorState state;
  SignInScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
    return Scaffold(
      body: Padding(
        padding: padding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // app logo
              const Center(child: FlutterLogo(size: 100)),
              // prebuilt sign in form from amplify_authenticator package
              SignInForm.custom(
                fields: [
                  SignInFormField.username(),
                  SignInFormField.password(),
                ],
              ),
            ],
          ),
        ),
      ),
      // custom button to take the user to sign up
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account?'),
            TextButton(
              onPressed: () => state.changeStep(
                AuthenticatorStep.signUp,
              ),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ],
    );
  }
}
