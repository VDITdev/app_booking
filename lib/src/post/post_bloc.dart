import 'package:bloc/bloc.dart';

import '../../models/Post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(Loading_PostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event == Load_PostEvent) {
      yield Loading_PostState();
      try {} catch (e) {}
    }
  }
}
