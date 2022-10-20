import 'package:app_booking/models/User.dart';
import 'package:app_booking/src/auth/auth_repo.dart';
import 'package:app_booking/utils/state/status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninState());
  final AuthRepository _authRepo = AuthRepository();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is EmailSigninEvent) {
      yield state.copyWith(email: event.email);
    } else if (event is PasswordSigninEvent) {
      yield state.copyWith(password: event.password);
    } else if (event is SubmissionSigninEvent) {
      try {
        await _authRepo.signIn(
          username: state.email,
          password: state.password,
        );
        yield state.copyWith(status: StatusSucess());
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
        yield state.copyWith(status: StatusInitial());
      }
    }
  }
}
