part of 'auth_bloc.dart';

abstract class AuthEvent {}

class Init_AuthEvent extends AuthEvent {}

// ------------------------------------------

class SignIn_AuthEvent extends AuthEvent {}

class SignUp_AuthEvent extends AuthEvent {}

class SignOut_AuthEvent extends AuthEvent {}
