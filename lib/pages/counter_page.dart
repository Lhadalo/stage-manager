import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:stage_manager/components/counters_list.dart';
import 'package:stage_manager/pages/edit_counter_page.dart';
import 'package:stage_manager/scoped_models/main.dart';
import 'package:stage_manager/util/localization.dart';
import 'package:stage_manager/components/FadeRoute.dart';

class CounterPage extends StatelessWidget {
  Widget _buildFAB(BuildContext context, MainModel model) {
    return FloatingActionButton.extended(
        label: Text(Localization.of(context).getString('btn_edit')),
        icon: Icon(Icons.edit),
        onPressed: () => Navigator.push(context, FadeRoute(EditCounterPage()))
        // onPressed: () => Navigator.of(context).pushNamed(EditCounterPage.routeName),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
          return Scaffold(
              appBar: AppBar(
                title: Text(Localization.of(context).getString('title')),
                backgroundColor: Colors.black,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton:
                  (model.showPosition == 0) ? _buildFAB(context, model) : null,
              body: CountersList());
        
      },
    );
  }
}
