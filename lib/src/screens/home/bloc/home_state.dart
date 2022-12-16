part of 'home_cubit.dart';

abstract class HomeState {
  late List<PostData> posts;

  HomeState(HomeState? state) {
    posts = state?.posts ?? [];
  }
}

class HomeInitial extends HomeState {
  HomeInitial({HomeState? state}) : super(state);
}

class DataPostsState extends HomeState {
  DataPostsState(super.state);
}

class PostsLoadingState extends DataPostsState {
  PostsLoadingState(super.state);
}

class PostsLoadedState extends DataPostsState {
  PostsLoadedState(super.state);
}
