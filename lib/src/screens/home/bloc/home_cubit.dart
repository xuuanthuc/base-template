import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../global/utilities/permission.dart';
import '../../../models/response/post.dart';
import '../../../repositories/post_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PostRepository _postRepository = PostRepository();

  HomeCubit() : super(HomeInitial());

  getPosts() async {
    emit(PostsLoadingState(state));
    List<PostData> posts = [];
    try {
      posts = await _postRepository.getPosts();
    } catch (_) {}
    emit(PostsLoadedState(state..posts = posts));
  }

  void pickImage(ImageSource imageSource) async {
    var access = await RequestPermission.canAccessImagePicker(imageSource);
    if (access != null && access) {
      ImagePicker().pickImage(source: imageSource);
    } else if (access != null && !access) {
      emit(CameraPermissionDeniedState(state));
    }
  }
}
