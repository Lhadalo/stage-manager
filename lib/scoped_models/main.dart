import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:stage_manager/scoped_models/connected_counters.dart';
import 'package:stage_manager/scoped_models/counters_model.dart';
import 'package:stage_manager/scoped_models/show_model.dart';

const int NOT_STARTED = 0;
const int STARTED = 1;
const int FINISHED = 2;

class MainModel extends Model with ConnectedCounters, CountersModel, ShowModel {
  
}