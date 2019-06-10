import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stage_manager/util/localization.dart';
import 'package:stage_manager/pages/counter_page.dart';
import 'package:stage_manager/pages/edit_counter_page.dart';
import 'package:stage_manager/scoped_models/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final MainModel _mainModel = MainModel();
  bool _isEmpty = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _mainModel.readCountersFromDisc();
    _mainModel.isEmpty.addListener(() {
      setState(() {
        _isEmpty = _mainModel.isEmpty.value;
      });
    });
    super.initState();
  }

@override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  print(state);
}

  Widget _getStartPage() {
    return _isEmpty ? EditCounterPage() :CounterPage();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _mainModel,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            accentColor: Colors.blueAccent,
            scaffoldBackgroundColor: Colors.black),
        home: _getStartPage(),
        localizationsDelegates: [
          const LocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale(
            'sv',
          )
        ],
      ),
    );
  }
}
