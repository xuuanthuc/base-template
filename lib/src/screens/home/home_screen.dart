import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/global/utilities/toast.dart';
import '../../global_bloc/connectivity/connectivity_bloc.dart';
import 'bloc/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityChangedState) {
          if (state.result == ConnectivityResult.none) {
            appToast(context, message: "No connection");
          }
        }
      },
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getPosts();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is CameraPermissionDeniedState) {
          _showMyDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) {
                return current is DataAvatarState;
              },
              builder: (context, state) {
                return state.imageFile == null
                    ? Container()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        child: Image.file(
                          state.imageFile!,
                          fit: BoxFit.cover,
                        ),
                      );
              },
            ),
            ElevatedButton(
              onPressed: () =>
                  context.read<HomeCubit>().pickImage(ImageSource.camera),
              child: const Text('Open camera'),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.read<HomeCubit>().pickImage(ImageSource.gallery),
              child: const Text('Open gallery'),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) {
                return current is DataPostsState;
              },
              builder: (context, state) {
                if (state is PostsLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          state.posts[index].body ?? '',
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                    itemCount: state.posts.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
