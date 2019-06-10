import 'package:flutter/material.dart';
import 'package:stage_manager/scoped_models/main.dart';
import 'package:stage_manager/scoped_models/connected_counters.dart';
import 'package:stage_manager/util/timer_service.dart';
import 'package:stage_manager/models/counter.dart';
import 'package:stage_manager/util/localization.dart';
import 'package:stage_manager/util/time_format.dart';
import 'package:share/share.dart';

mixin ShowModel on ConnectedCounters {
  final TimerService timerService = new TimerService();
  Duration currentElapsed = Duration.zero;
  int showPosition = 0;
  bool showFinished = false;
  bool inEditMode = false;

  void increaseShowPosition() {
    _updateCounterData();

    if (showPosition > 0)
      currentElapsed = Duration(seconds: timerService.currentElapsed.inSeconds);
    else
      timerService.start();

    showPosition++;
    notifyListeners();
  }

  void finishShow() {
    counters[showPosition - 1] =
        _getFinishedCounter(counters[showPosition - 1], DateTime.now());
    currentElapsed = Duration(seconds: timerService.currentElapsed.inSeconds);
    timerService.stop();
    showFinished = true;
    notifyListeners();
  }

  void resetShow() {
    timerService.reset();
    resetCounters();
    showPosition = NOT_STARTED;
    showFinished = false;
    currentElapsed = Duration();
    notifyListeners();
  }

  void shareShow(BuildContext context) {
    String result = _formatResult(context);
    Share.share(result);
  }

  void toggleEditMode() {
    this.inEditMode = !this.inEditMode;
    notifyListeners();
  }

  String _formatResult(BuildContext context) {
    String result = '';
    for (Counter counter in counters)
      result += '${getAct(counter, context)}\n\n';
    result +=
        '${Localization.of(context).getString('share_total_time')} : ${TimeFormat.formatDuration(currentElapsed)}';
    return result;
  }

  String getAct(Counter counter, BuildContext context) {
    Localization l = Localization.of(context);
    String started = l.getString('share_started');
    String ended = l.getString('share_ended');
    String time = l.getString('share_total_time');

    return '${counter.title}\n\t' +
        '$started: ${TimeFormat.formatTime(counter.startTime)}\n\t' +
        '$ended: ${TimeFormat.formatTime(counter.finishTime)}\n\t' +
        '$time: ${TimeFormat.formatDuration(counter.elapsedTime)}';
  }

  Counter _getFinishedCounter(Counter counter, DateTime finishTime) {
    return Counter(counter.title,
        counterStatus: FINISHED,
        startTime: counter.startTime,
        finishTime: finishTime,
        elapsedTime: timerService.currentElapsed - currentElapsed);
  }

  Counter _getStartedCounter(Counter counter, DateTime startTime) {
    return Counter(counter.title, counterStatus: STARTED, startTime: startTime);
  }

  void _updateCounterData() {
    var now = DateTime.now();

    if (showPosition > 0) {
      Counter updatedCounter =
          _getFinishedCounter(counters[showPosition - 1], now);
      counters[showPosition - 1] = updatedCounter;
    }
    Counter updatedCounter = _getStartedCounter(counters[showPosition], now);
    counters[showPosition] = updatedCounter;
  }
}
