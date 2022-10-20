import 'package:app_booking/src/auth/auth_repo.dart';
import 'package:app_booking/utils/state/status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState());
  AuthRepository _authRepo = AuthRepository();
  // final _ssRepo = SessionRepository.instance;
  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is UsernameSignupEvent) {
      yield state.copyWith(username: event.username);
    } else if (event is PasswordSignupEvent) {
      yield state.copyWith(password: event.password);
    } else if (event is EmailSignupEvent) {
      yield state.copyWith(email: event.email);
    } else if (event is SubmissionSignupEvent) {
      yield state.copyWith(status: StatusLoading());
      try {
        await _authRepo.signUp(
          username: state.username,
          email: state.email,
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