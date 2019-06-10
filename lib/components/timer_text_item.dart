import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stage_manager/scoped_models/main.dart';
import 'package:stage_manager/util/time_format.dart';

class TimerText extends StatefulWidget {
  final bool showTotalTime;

  TimerText({this.showTotalTime = false});

  createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  List<ValueChanged<Duration>> _elapsedTimeListeners;
  Duration _previousElapsed;
  Duration _currentElapsed = Duration.zero;
  TextStyle style;

  @override
  void initState() {
    _elapsedTimeListeners =
        ScopedModel.of<MainModel>(context).timerService.elapsedTimeListeners;
    _elapsedTimeListeners.add(_onTick);

    if (widget.showTotalTime) {
      style = TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal);
    } else {
      _previousElapsed = ScopedModel.of<MainModel>(context).currentElapsed;
      style = TextStyle(fontSize: 40.0, fontWeight: FontWeight.w200);
    }

    super.initState();
  }

  @override
  void dispose() {
    _elapsedTimeListeners.remove(_onTick);
    super.dispose();
  }

  void _onTick(Duration duration) {
    Duration elapsed =
        widget.showTotalTime ? duration : duration - _previousElapsed;
    setState(() {
      _currentElapsed = elapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      TimeFormat.formatDuration(_currentElapsed),
      style: style,
    );
  }
}
