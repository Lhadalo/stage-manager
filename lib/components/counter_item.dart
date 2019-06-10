import 'package:flutter/material.dart';
import 'package:stage_manager/components/timer_text_item.dart';
import 'package:stage_manager/models/counter.dart';
import 'package:stage_manager/util/localization.dart';
import 'package:stage_manager/scoped_models/main.dart';
import 'package:stage_manager/util/time_format.dart';

class CounterItem extends StatelessWidget {
  final Counter counter;
  final bool isNextStart;
  final Function onPressStart;

  CounterItem(this.counter, this.isNextStart, this.onPressStart);

  TextStyle _getTitleTextStyle() {
    return TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  }

  Widget _buildIdleListItem(BuildContext context) {
    return ListTile(
      title: Text(counter.title, style: _getTitleTextStyle()),
      trailing: isNextStart
          ? OutlineButton(
              onPressed: () => this.onPressStart(),
              child: Text(Localization.of(context).getString('btn_start')))
          : null,
    );
  }

  Widget _buildStartedListItem(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            counter.title,
            style: _getTitleTextStyle(),
          ),
        ),
        Center(child: TimerText()),
        Center(
          child: Text(
            Localization.of(context).getString('title_started'),
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Center(
          child: Text(
            TimeFormat.formatTime(counter.startTime),
            style: TextStyle(
                color: Colors.green,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  Widget _buildFinishedListItem(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            counter.title,
            style: _getTitleTextStyle(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  Localization.of(context).getString('title_start_time'),
                  style: TextStyle(color: Colors.grey),
                ),
                Text(TimeFormat.formatTime(counter.startTime)),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  Localization.of(context).getString('title_stop_time'),                  
                  style: TextStyle(color: Colors.grey),
                ),
                Text(TimeFormat.formatTime(counter.finishTime)),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  Localization.of(context).getString('title_duration'),
                  style: TextStyle(color: Colors.grey),
                ),
                Text(TimeFormat.formatDuration(counter.elapsedTime)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget listItem;
    switch(counter.counterStatus) {
      case NOT_STARTED:
            listItem = _buildIdleListItem(context);
            break;
          case STARTED:
            listItem = _buildStartedListItem(context);
            break;
          case FINISHED:
            listItem = _buildFinishedListItem(context);
            break;
    }
    return listItem;
  }
}
