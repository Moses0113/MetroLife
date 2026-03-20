/// Focus Timer (Pomodoro) Riverpod Provider
/// 參考: prd.md Section 3.5

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimerState { idle, running, paused }

class FocusTimerData {
  final TimerState state;
  final int totalSeconds;
  final int remainingSeconds;
  final bool isBreak;
  final int focusDurationMinutes;
  final int breakDurationMinutes;

  const FocusTimerData({
    this.state = TimerState.idle,
    this.totalSeconds = 0,
    this.remainingSeconds = 0,
    this.isBreak = false,
    this.focusDurationMinutes = 25,
    this.breakDurationMinutes = 5,
  });

  double get progress {
    if (totalSeconds == 0) return 0;
    return 1 - (remainingSeconds / totalSeconds);
  }

  FocusTimerData copyWith({
    TimerState? state,
    int? totalSeconds,
    int? remainingSeconds,
    bool? isBreak,
    int? focusDurationMinutes,
    int? breakDurationMinutes,
  }) {
    return FocusTimerData(
      state: state ?? this.state,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isBreak: isBreak ?? this.isBreak,
      focusDurationMinutes: focusDurationMinutes ?? this.focusDurationMinutes,
      breakDurationMinutes: breakDurationMinutes ?? this.breakDurationMinutes,
    );
  }
}

class FocusTimerNotifier extends Notifier<FocusTimerData> {
  Timer? _timer;

  @override
  FocusTimerData build() {
    _loadSettings();
    return const FocusTimerData();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final focusMin = prefs.getInt('focus_duration') ?? 25;
    final breakMin = prefs.getInt('break_duration') ?? 5;
    state = state.copyWith(
      focusDurationMinutes: focusMin,
      breakDurationMinutes: breakMin,
      totalSeconds: focusMin * 60,
      remainingSeconds: focusMin * 60,
    );
  }

  void start() {
    if (state.state == TimerState.running) return;

    int total = state.isBreak
        ? state.breakDurationMinutes * 60
        : state.focusDurationMinutes * 60;
    int remaining = state.state == TimerState.paused
        ? state.remainingSeconds
        : total;

    state = state.copyWith(
      state: TimerState.running,
      totalSeconds: total,
      remainingSeconds: remaining,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 0) {
        timer.cancel();
        state = state.copyWith(state: TimerState.idle);
        return;
      }
      state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
    });
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(state: TimerState.paused);
  }

  void stop() {
    _timer?.cancel();
    state = FocusTimerData(
      focusDurationMinutes: state.focusDurationMinutes,
      breakDurationMinutes: state.breakDurationMinutes,
      totalSeconds: state.focusDurationMinutes * 60,
      remainingSeconds: state.focusDurationMinutes * 60,
    );
  }

  void reset() {
    _timer?.cancel();
    int total = state.isBreak
        ? state.breakDurationMinutes * 60
        : state.focusDurationMinutes * 60;
    state = state.copyWith(
      state: TimerState.idle,
      totalSeconds: total,
      remainingSeconds: total,
    );
  }

  void switchToBreak() {
    _timer?.cancel();
    final breakSec = state.breakDurationMinutes * 60;
    state = state.copyWith(
      state: TimerState.idle,
      isBreak: true,
      totalSeconds: breakSec,
      remainingSeconds: breakSec,
    );
  }

  void switchToFocus() {
    _timer?.cancel();
    final focusSec = state.focusDurationMinutes * 60;
    state = state.copyWith(
      state: TimerState.idle,
      isBreak: false,
      totalSeconds: focusSec,
      remainingSeconds: focusSec,
    );
  }

  Future<void> saveDurations(int focusMin, int breakMin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('focus_duration', focusMin);
    await prefs.setInt('break_duration', breakMin);
    state = state.copyWith(
      focusDurationMinutes: focusMin,
      breakDurationMinutes: breakMin,
      totalSeconds: focusMin * 60,
      remainingSeconds: focusMin * 60,
    );
  }

  /// Returns true if the timer just completed
  bool get isCompleted =>
      state.remainingSeconds <= 0 &&
      state.state == TimerState.idle &&
      state.totalSeconds > 0;
}

final focusTimerProvider = NotifierProvider<FocusTimerNotifier, FocusTimerData>(
  FocusTimerNotifier.new,
);
