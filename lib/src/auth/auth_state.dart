part of 'auth_bloc.dart';

class AuthState {
  User? user;
  Status? status;

  AuthState({
    this.user,
    this.status = const StatusInitial(),
  });

  AuthState copyWith({
    User? user,
    Status? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}

class Init_AuthState extends AuthState {}

class SignIn_AuthState extends AuthState {}

class SignUp_AuthState extends AuthState {}

// ----------------------------------------

class Unknown_AuthState extends AuthState {}

class Authen_AuthState extends AuthState {
  final String userId;
  Authen_AuthState({required this.userId});
}

class Unauthen_AuthState extends AuthState {}
