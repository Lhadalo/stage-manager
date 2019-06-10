import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stage_manager/util/data_util.dart';
import 'package:stage_manager/scoped_models/connected_counters.dart';
import 'package:stage_manager/models/counter.dart';

mixin CountersModel on ConnectedCounters {
  final isEmpty = ValueNotifier(true);

  void addCounter(Counter counter) {
    this.add(counter);
    notifyListeners();

    DataUtil.saveCounters(counters);
    if (!counter.isIntermission) {
      nbrActs++;
    }
  }

  void updateCounter(int index, Counter counter) {
    this.update(index, counter);
    notifyListeners();
    DataUtil.saveCounters(counters);
  }

  void deleteCounter(int index) {
    if (!counters[index].isIntermission && nbrActs > 0) {
      nbrActs--;
    }

    this.remove(index);
    notifyListeners();
    DataUtil.saveCounters(counters);
  }

  void readCountersFromDisc() {
    DataUtil.readCounters().then((value) {
      this.init(value);
      isEmpty.value = value.isEmpty;
      calcNbrActs();
      notifyListeners();
    });
  }

  calcNbrActs() => counters.forEach((c) => !c.isIntermission ? nbrActs++ : null);

  Future<int> get calculateNbrActs async {
    int acts = 0;
    for (Counter counter in counters) {
      if (!counter.isIntermission) {
        acts++;
      }
    }
    return acts;
  }
}
