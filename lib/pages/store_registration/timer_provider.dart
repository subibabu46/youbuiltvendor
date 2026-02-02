import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';

class OtpTimerState {
  final int secondsLeft;
  final bool isRunning;

  OtpTimerState({required this.secondsLeft, this.isRunning = false});

  OtpTimerState copyWith({int? secondsLeft, bool? isRunning}) {
    return OtpTimerState(
      secondsLeft: secondsLeft ?? this.secondsLeft,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}

class OtpTimerNotifier extends StateNotifier<OtpTimerState> {
  static const int initialTime = 60;
  Timer? _timer;

  OtpTimerNotifier() : super(OtpTimerState(secondsLeft: initialTime));

  void start() {
    _timer?.cancel();
    state = state.copyWith(secondsLeft: initialTime, isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsLeft <= 0) {
        timer.cancel();
        state = state.copyWith(isRunning: false);
      } else {
        state = state.copyWith(secondsLeft: state.secondsLeft - 1);
      }
    });
  }

  void reset() {
    _timer?.cancel();
    state = state.copyWith(secondsLeft: initialTime, isRunning: false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final otpTimerProvider = StateNotifierProvider<OtpTimerNotifier, OtpTimerState>(
  (ref) {
    return OtpTimerNotifier();
  },
);
