part of 'home_cubit.dart';

abstract class HomeState {
  late int number;
  late bool hasColor;

  HomeState(HomeState? state) {
    number = state?.number ?? 0;
    hasColor = state?.hasColor ?? false;
  }
}

class HomeInitial extends HomeState {
  HomeInitial({HomeState? state}) : super(state);
}

class DataNumberState extends HomeState {
  DataNumberState(super.state);
}

class NumberChangingState extends DataNumberState {
  NumberChangingState(super.state);
}

class NumberChangedState extends DataNumberState {
  NumberChangedState(super.state);
}

class DataColorState extends HomeState {
  DataColorState(super.state);
}

class ColorChangingState extends DataColorState {
  ColorChangingState(super.state);
}

class ColorChangedState extends DataColorState {
  ColorChangedState(super.state);
}
