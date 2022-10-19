import 'package:app_booking/screens/auth/auth_screen.dart';
import 'package:app_booking/src/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


const AUTHEN_ROUTE = "/auth";
const SIGNIN_ROUTE = "/signin";
const SIGNUP_ROUTE = "/signup";
const HOME_ROUTE = "/home";

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTHEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthBloc(),
            child: AuthScreen(),
          ),
        );
    }
    return null;
  }
}