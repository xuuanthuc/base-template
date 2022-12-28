part of 'home_cubit.dart';

abstract class HomeState {
  late List<PostData> posts;
  File? imageFile;

  HomeState(HomeState? state) {
    posts = state?.posts ?? [];
    imageFile = state?.imageFile;
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

class DataAvatarState extends HomeState{
  DataAvatarState(super.state);
}

class CameraPermissionDeniedState extends DataAvatarState{
  CameraPermissionDeniedState(super.state);
}

class ImagePickedState extends DataAvatarState{
  ImagePickedState(super.state);
}