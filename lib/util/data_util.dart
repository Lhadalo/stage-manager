import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:stage_manager/models/counter.dart';

class DataUtil {
  static Future<List<Counter>> readCounters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedCounters = prefs.getStringList('counters');

    if (encodedCounters != null) {
      var countersMap = encodedCounters.map((cl) => jsonDecode(cl)).toList();
      return countersMap.map((cm) => Counter.fromJson(cm)).toList();
    } else {
      return [];
    }
  }

  static void saveCounters(List<Counter> counters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var encodedCounters = counters.map((counter) => jsonEncode(counter)).toList();
    await prefs.setStringList('counters', encodedCounters);
  }
}
