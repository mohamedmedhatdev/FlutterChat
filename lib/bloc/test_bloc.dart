import 'package:flutter_application_1/bloc/test_event.dart';
import 'package:flutter_application_1/bloc/test_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestState(0)) {
    on<TestIncreaseCounter>((event, emit) {
      emit(TestState(state.counter + 1));
    });
    on<TestDescreaseCounter>((event, emit) {
      emit(TestState(state.counter - 1));
    });
  }
}
