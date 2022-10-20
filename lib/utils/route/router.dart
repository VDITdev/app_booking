import 'package:app_booking/screens/auth/auth_screen.dart';
import 'package:app_booking/screens/home/home.dart';
import 'package:app_booking/screens/onboard/onboard_screen.dart';
import 'package:app_booking/screens/signin/signin_screen.dart';
import 'package:app_booking/screens/signup/signup_screen.dart';
import 'package:app_booking/src/auth/auth_bloc.dart';
import 'package:app_booking/src/signin/signin_bloc.dart';
import 'package:app_booking/src/signup/signup_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const ONBOARD_ROUTE = "/";
const AUTHEN_ROUTE = "/auth";
const SIGNIN_ROUTE = "/signin";
const SIGNUP_ROUTE = "/signup";
const HOME_ROUTE = "/home";

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ONBOARD_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const OnboardScreen(),
        );

      case SIGNIN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SigninBloc(),
            child: const SignInScreen(),
          ),
        );

      case SIGNUP_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupBloc(),
            child: SignUpScreen(),
          ),
        );

      case AUTHEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthBloc(),
            child: AuthScreen(),
          ),
        );
      case HOME_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthBloc(),
            child: const HomeView(),
          ),
        );
    }
    return null;
  }
}
