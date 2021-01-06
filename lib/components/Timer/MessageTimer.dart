import 'dart:async';

import 'package:flutter/material.dart';

class MessageTimer extends StatefulWidget{

  final int count;
  Function onTimerEnd;
  Function onSendCode;

  MessageTimer({ this.count = 60, this.onTimerEnd, this.onSendCode });
  @override
  _CodeTimeState createState() {
    return _CodeTimeState();
  }
  
}

class _CodeTimeState extends State<MessageTimer> {

  int count = 60;
  Timer timer;
  String codeText = '发送验证码';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sendCode,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).accentColor
        ),
        child: Text(
          codeText,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white
          ),
        ),
      )
    );
  }


  // 点击发送验证码
  void sendCode() {
    if (count == widget.count) {
      widget.onSendCode ?? widget.onSendCode();
      _initTimer();
      setState(() {     
        codeText = '重新发送(${widget.count})';
      });
    }
  }

  // 倒计时状态控制
  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      //数据操作处理
      setState(() {
        if (count == 1) {
          timer.cancel(); //倒计时结束取消定时器
          count = widget.count; //重置时间
          codeText = '重新发送';
        } else {   
          count--;
          codeText = '重新发送($count)';
        }
      });
    });
  }

  void initCount() {
    setState(() {
      count = widget.count;
    });
  }

  @override
  void initState() {
    super.initState();
    initCount();
  }


  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

}