part of 'post_bloc.dart';

abstract class PostState {}

class Loading_PostState extends PostState {}

class Loaded_PostState extends PostState {
  List<Post> posts;
  Loaded_PostState({required this.posts});
}

class Unload_PostState extends PostState {
  Error e;
  Unload_PostState({required this.e});
}
