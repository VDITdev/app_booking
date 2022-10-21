import 'package:app_booking/models/User.dart';
import 'package:app_booking/src/auth/auth_repo.dart';
import 'package:app_booking/utils/state/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Init_AuthState());

  final _authRepo = AuthRepository();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {

    if (event is SignIn_AuthEvent) {
      yield SignIn_AuthState();
    }

    if (event is SignUp_AuthEvent) {
      yield SignUp_AuthState();
    }

    if (event is SignOut_AuthEvent) {
      await _authRepo.signOut();
    }

    // else if (event is SignIn_AuthEvent) {
    //   final userId = await authRepo.fetchUserIdFromAttributes();
    //   try {
    //     yield Authen_AuthState(userId: userId);
    //   } catch (e) {
    //     yield Unauthen_AuthState();
    //   }
    // } else if (event is SignUp_AuthEvent) {
    // } else if (event is SignOut_AuthEvent) {
    //   try {
    //     await authRepo.signOut();
    //   } catch (e) {
    //     yield Unauthen_AuthState();
    //   }
    // }
  }
}
