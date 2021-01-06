import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app/components/Timer/MessageTimer.dart';
import 'package:app/components/Timer/ExpireTimer.dart';

class TimerPage extends StatefulWidget {
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('倒计时组件'),
      ),
      body: Column(
        children: <Widget>[
          Text('发送短信倒计时'),
          MessageTimer(
            count: 60,
            onSendCode: () {
              Utils.showToast('发送验证码');
            }
          ),
          Text('过期的倒计时'),
          ExpireTimer()
        ],
      )
    );
  }
}