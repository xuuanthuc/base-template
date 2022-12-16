import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/public/routes/navigation_service.dart';
import 'package:template/public/routes/route_keys.dart';
import 'package:template/src/screens/home/bloc/home_cubit.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) {
              return current is DataNumberState;
            },
            builder: (context, state) {
              return Text(
                state.number.toString(),
                textAlign: TextAlign.center,
              );
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) {
              return current is DataColorState;
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () => context.read<HomeCubit>().changeColor(),
                child: Container(
                  color: state.hasColor ? Colors.red : Colors.yellow,
                  height: 100,
                  width: 100,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () => navService.pushNamed(RouteKey.root),
            icon: const Icon(Icons.arrow_forward_sharp),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeCubit>().increaseNumber();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
