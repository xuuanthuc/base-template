import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/models/response/post.dart';
import '../../../repositories/post_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PostRepository _postRepository = PostRepository();
  HomeCubit() : super(HomeInitial());

  getPosts() async {
    emit(PostsLoadingState(state));
    await Future.delayed(const Duration(seconds: 1));
    final posts = await _postRepository.getPosts();
    emit(PostsLoadedState(state..posts = posts));
  }
}
