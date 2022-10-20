import 'package:app_booking/src/signin/signin_bloc.dart';
import 'package:app_booking/utils/route/router.dart';
import 'package:app_booking/utils/state/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.status is StatusSucess) {
          Navigator.popAndPushNamed(context, HOME_ROUTE);
        }
        if (state.status is StatusFailed) {
          _showSnackBar(context, 'Invalid User\nPlease create account first');
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [_loginForm(), _showSignUpButton()],
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(icon: Icon(Icons.email), hintText: "Email"),
      validator: (value) {},
      onChanged: (value) {
        // print("email: " + value);
        context.read<SigninBloc>().add(EmailSigninEvent(email: value));
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(icon: Icon(Icons.security), hintText: "Password"),
      validator: (value) {},
      onChanged: (value) =>
          context.read<SigninBloc>().add(PasswordSigninEvent(password: value)),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              _passwordField(),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Flexible(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<SigninBloc>().add(SubmissionSigninEvent());
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Widget _showSignUpButton() {
    return SafeArea(
      child: TextButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, SIGNUP_ROUTE);
        },
        child: Text('Don\'t have an account yet? Sign Up'),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      duration: Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
