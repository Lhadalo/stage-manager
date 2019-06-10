import 'dart:async';

import 'package:flutter/material.dart';

class TimerService {
  final List<ValueChanged<Duration>> elapsedTimeListeners =
      <ValueChanged<Duration>>[];
  Duration currentElapsed;
  Stopwatch _watch;
  Timer _timer;

  TimerService() {
    _watch = new Stopwatch();
  }

  void start() {
    _timer = Timer.periodic(Duration(milliseconds: 500), _onTick);
    _watch.start();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
  }

  void reset() {
    stop();
    _watch.reset();
    currentElapsed = Duration();
    for (final listener in elapsedTimeListeners) {
      listener(currentElapsed);
    }
  }

  void _onTick(Timer timer) {
    if (currentElapsed != _watch.elapsed) {
      currentElapsed = _watch.elapsed;
      for (final listener in elapsedTimeListeners) {
        listener(currentElapsed);
      }
    }
  }
}
