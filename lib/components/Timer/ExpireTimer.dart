import 'dart:async';

import 'package:flutter/material.dart';

class ExpireTimer extends StatefulWidget {

  final int expireSeconds;
  final Function onTimeEnd;

  const ExpireTimer({Key key, this.expireSeconds = 30 * 60, this.onTimeEnd}) : super(key: key);

  _ExpireTimer createState() => _ExpireTimer();
}

class _ExpireTimer extends State<ExpireTimer> {

  String timeString;

  Timer timer;

  int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(timeString),
    );
  }


  String addZero(int number) {
    if (number < 10) {
      return '0$number';
    }
    return '$number';
  }

  String getTimeString(int seconds) {
    int hour = seconds ~/ (60 * 60);
    int minute = (seconds - hour * 60 * 60) ~/ 60;
    int second = (seconds - hour * 60 * 60 - minute * 60) ~/ 1;
    print('$hour:$minute:$second');
    return '${addZero(hour)}:${addZero(minute)}:${addZero(second)}';
  }

  void initTimer() {
    count = widget.expireSeconds;
    Timer.periodic(Duration(seconds: 1), (timer) { 
      if (count == 0) {
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            count--;
            timeString = getTimeString(count);
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initTimer();
    setState(() {
      timeString = getTimeString(widget.expireSeconds);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

}