import 'package:app_booking/src/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Sign In'),
          onPressed: () => BlocProvider.of<AuthBloc>(context)
              .add(SignIn_AuthEvent(userId: 'abc')),
        ),
      ),
    );
  }
}
