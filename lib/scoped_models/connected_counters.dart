import 'package:scoped_model/scoped_model.dart';

import 'package:stage_manager/models/counter.dart';

mixin ConnectedCounters on Model {
  int nbrActs = 0;
  
  List<Counter> counters = [];
  List<Counter> _counters = [];

  void resetCounters() {
    counters.setAll(0, _counters);
  }

  void init(List<Counter> counters) {
    this.counters = counters;
    this._counters = List.of(counters);
  }

  update(int index, Counter counter) {
    this.counters[index] = counter;
    this._counters[index] = counter;
  }

  void remove(int index) {
    counters.removeAt(index);
    _counters.removeAt(index);
  }

  void add(Counter counter) {
    this.counters.add(counter);
    this._counters.add(counter);
  }

  
}