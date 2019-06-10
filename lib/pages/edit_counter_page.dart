import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stage_manager/components/FadeRoute.dart';
import 'package:stage_manager/pages/counter_page.dart';
import 'package:stage_manager/util/localization.dart';
import 'package:stage_manager/models/counter.dart';
import 'package:stage_manager/scoped_models/main.dart';

class EditCounterPage extends StatefulWidget {
  static final String routeName = 'edit_counter';

  _EditCounterPageState createState() => new _EditCounterPageState();
}

class _EditCounterPageState extends State<EditCounterPage> {
  final TextEditingController titleController = new TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void onPressedEdit(MainModel model, int index) {
    Counter counter = model.counters[index];
    titleController.text = counter.title;

    buildInputDialog().then((Counter updatedCounter) {
      if (updatedCounter != null) model.updateCounter(index, updatedCounter);
    });
  }

  void onPressedDelete(MainModel model, int index) {
    model.deleteCounter(index);
  }

  Future<Counter> buildInputDialog() {
    return showDialog<Counter>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Localization.of(context).getString('alert_add_title')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: Localization.of(context)
                            .getString('alert_add_label'),
                        hintText: Localization.of(context)
                            .getString('alert_add_hint')),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(Localization.of(context)
                      .getString('alert_add_btn_negative')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                child: Text(Localization.of(context)
                    .getString('alert_add_btn_positive')),
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    Navigator.of(context).pop(Counter(titleController.text));
                  }
                },
              )
            ],
          );
        });
  }

  OutlineButton buildButton(
          String title, MainModel model, bool isIntermission) =>
      OutlineButton(
        child: Text(title),
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () => model.addCounter(Counter(
            Localization.of(context).getCounterTitle(model.nbrActs + 1,
                isIntermission: isIntermission),
            isIntermission: isIntermission)),
      );

  ListView buildList(MainModel model) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),
      separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.white70,
          ),
      itemBuilder: (BuildContext context, int index) {
        Counter counter = model.counters[index];
        return ListTile(
          title: Text(
            counter.title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () => this.onPressedEdit(model, index),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white54,
                ),
              ),
              IconButton(
                onPressed: () => this.onPressedDelete(model, index),
                icon: Icon(
                  Icons.delete,
                  color: Colors.white54,
                ),
              )
            ],
          ),
        );
      },
      itemCount: model.counters.length,
    );
  }

  Widget buildEmptyState() {
    return Center(
      child:
          Text(Localization.of(context).getString('edit_counters_empty_state')),
    );
  }

  Widget _buildFAB(BuildContext context, MainModel model) {
    return FloatingActionButton.extended(
        label: Text('Spara'),
        icon: Icon(Icons.check),
        backgroundColor: Colors.green,
        onPressed: () {
          if (model.counters.length > 0) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacement(FadeRoute(CounterPage()));
            }
          }

          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CounterPage()));
        }
        // onPressed: () => Navigator.of(context).pushNamed(EditCounterPage.routeName),
        );
  }

  @override
  Widget build(BuildContext context) {
    String strAddPaus =
        Localization.of(context).getString('btn_add_paus').toUpperCase();
    String strAddAct =
        Localization.of(context).getString('btn_add_act').toUpperCase();
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Text(Localization.of(context).getString('title')),
          ),
          floatingActionButton: _buildFAB(context, model
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Container(
              margin: EdgeInsetsDirectional.only(bottom: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  (model.counters.length > 0)
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: this.buildList(model),
                          ),
                        )
                      : Expanded(child: this.buildEmptyState()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: this.buildButton(strAddPaus, model, true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: this.buildButton(strAddAct, model, false),
                  ),
                ],
              )),
        );
      },
    );
  }
}
