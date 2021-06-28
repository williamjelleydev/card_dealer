import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class SwipeableCard extends StatelessWidget {
  final String card;
  final StreamController<double> swipeController = StreamController<double>();
  final Function onSwipeCallback;

  SwipeableCard({this.card, this.onSwipeCallback});

  @override
  Widget build(BuildContext context) {
    return Swipable(
        onSwipeEnd: onSwipeCallback,
        swipe: swipeController.stream,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(card),
        )
    );
  }

  StreamController<double> getSwipeController() {
    return swipeController;
  }
}