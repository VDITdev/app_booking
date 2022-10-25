import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatelessWidget {
  AuthenticatorState state;
  SignUpScreen({
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
              // prebuilt sign up form from amplify_authenticator package
              SignUpForm.custom(
                fields: [
                  SignUpFormField.email(required: true),
                  SignUpFormField.password(),
                  SignUpFormField.passwordConfirmation(),
                  SignUpFormField.phoneNumber(required: true),
                  SignUpFormField.name()
                ],
              ),
            ],
          ),
        ),
      ),
      // custom button to take the user to sign in
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            TextButton(
              onPressed: () => state.changeStep(
                AuthenticatorStep.signIn,
              ),
              child: const Text('Sign In'),
            ),
          ],
        ),
      ],
    );
    ;
  }
}
