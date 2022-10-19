part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignIn_AuthEvent extends AuthEvent {
  final String userId;
  SignIn_AuthEvent({required this.userId});
}

class SignUp_AuthEvent extends AuthEvent {}

class SignOut_AuthEvent extends AuthEvent {}
