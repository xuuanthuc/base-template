import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/global/utilities/public.dart';
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
      XFile? imagePicked;
      imagePicked = await ImagePicker().pickImage(source: imageSource);
      if (imagePicked == null) return;
      CroppedFile? imageCropped = await ImageCropper().cropImage(
        sourcePath: imagePicked.path,
        uiSettings: Public.uiSettings,
      );
      if (imageCropped == null) return;
      emit(ImagePickedState(state..imageFile = File(imageCropped.path)));
    } else if (access != null && !access) {
      emit(CameraPermissionDeniedState(state));
    }
  }
}
