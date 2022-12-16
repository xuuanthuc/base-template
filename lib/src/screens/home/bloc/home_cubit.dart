import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/public/ultilies/logger.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  increaseNumber() {
    emit(NumberChangedState(state));
    LoggerUtils.i(state.number + 1);
    emit(NumberChangedState(state..number = state.number + 1));
  }

  changeColor() {
    emit(ColorChangingState(state));
    LoggerUtils.i(!state.hasColor);
    emit(ColorChangedState(state..hasColor = !state.hasColor));
  }
}
