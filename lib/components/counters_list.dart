import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stage_manager/components/counter_item.dart';
import 'package:stage_manager/components/timer_text_item.dart';
import 'package:stage_manager/util/localization.dart';
import 'package:stage_manager/scoped_models/main.dart';

class CountersList extends StatelessWidget {
  Future<bool> _showAlert(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text(Localization.of(context).getString('alert_reset_title')),
            content:
                Text(Localization.of(context).getString('alert_reset_message')),
            actions: <Widget>[
              FlatButton(
                  child: Text(Localization.of(context)
                      .getString('alert_reset_btn_negative')),
                  onPressed: () => Navigator.of(context).pop(false)),
              FlatButton(
                  child: Text(Localization.of(context)
                      .getString('alert_reset_btn_positive')),
                  onPressed: () => Navigator.of(context).pop(true))
            ],
          );
        });
  }

  Widget _buildResetFinishButton(MainModel model, BuildContext context) {
    bool hasStarted = (model.showPosition > 0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: OutlineButton(
        onPressed: hasStarted
            ? () {
                if (model.showFinished) {
                  _showAlert(context).then(
                      (shouldReset) => shouldReset ? model.resetShow() : null);
                } else
                  model.finishShow();
              }
            : null,
        child: model.showFinished
            ? Text(Localization.of(context).getString('btn_reset'))
            : Text(Localization.of(context).getString('btn_finish')),
      ),
    );
  }

  Widget _buildMainCounter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Localization.of(context).getString('title_total_playing_time'),
          style: TextStyle(color: Colors.white70),
        ),
        TimerText(
          showTotalTime: true,
        )
      ],
    );
  }

  Widget _buildFinishedRow(MainModel model, BuildContext context) {
    return Center(
      child: FlatButton.icon(
        label: Text(Localization.of(context).getString('btn_share')),
        icon: Icon(Icons.share),
        onPressed: () => model.shareShow(context),
      ),
    );
  }

  Widget _buildCountersList(MainModel model) {
    int countersLength = model.counters.length;
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),
      separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.white70,
          ),
      itemBuilder: (BuildContext context, int index) {
        if (index < countersLength)
          return CounterItem(model.counters[index], model.showPosition == index,
              model.increaseShowPosition);
        else if (index == countersLength)
          return _buildResetFinishButton(model, context);
        else if (index == countersLength + 1)
          return _buildMainCounter(context);
        else if (model.showFinished) return _buildFinishedRow(model, context);
      },
      itemCount: countersLength + 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: _buildCountersList(model),
        );
      },
    );
  }
}
