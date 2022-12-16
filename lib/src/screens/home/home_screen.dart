import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeView(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
    );
  }
}
