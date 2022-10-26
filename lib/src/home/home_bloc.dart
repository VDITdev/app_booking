import 'package:app_booking/src/home/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(Init_HomeState());
  HomeRepository _homeRepo = HomeRepository();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState

    if (event is Init_HomeEvent) {
      await _homeRepo.fetchCurrentUserAttributes();
      // await _homeRepo.fetchAuthSession();
      // await _homeRepo.getCurrentUser();
      yield Init_HomeState();
    }

    if (event is SignOut_HomeEvent) {
      await _homeRepo.signOutCurrentUser();
      yield SignOut_HomeState();
    }
  }
}
