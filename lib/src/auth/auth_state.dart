part of 'auth_bloc.dart';

abstract class AuthState {}

class Unknown_AuthState extends AuthState {}

class Authen_AuthState extends AuthState {
  final String userId;
  Authen_AuthState({required this.userId});
}

class Unauthen_AuthState extends AuthState {}
