import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'real_time_state.dart';

class RealtimeCubit extends Cubit<DateTime> {
  RealtimeCubit() : super(DateTime.now()) {
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(DateTime.now());
    });
  }
}