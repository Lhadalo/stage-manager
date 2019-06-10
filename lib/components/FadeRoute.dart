import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget widget;
  FadeRoute(this.widget)
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondAnimation,
            Widget child) {
          return new FadeTransition(child: child, opacity: animation);
        });
}
