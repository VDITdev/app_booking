import 'package:app_booking/src/auth/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unknown_AuthState());
  final authRepo = AuthRepository();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event == SignIn_AuthEvent) {
      final userId = await authRepo.fetchUserIdFromAttributes();
      try {
        yield Authen_AuthState(userId: userId);
      } catch (e) {
        yield Unauthen_AuthState();
      }
    } else if (event == SignUp_AuthEvent) {
    } else if (event == SignOut_AuthEvent) {
      try {
        await authRepo.signOut();
      } catch (e) {
        yield Unauthen_AuthState();
      }
    }
  }
}
