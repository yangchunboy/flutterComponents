import 'package:flutter/material.dart';

class DeletePage extends StatefulWidget{
  @override
  _deletePageState createState() {
    return _deletePageState();
  }
  
}

class _deletePageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('滑动删除')
      ),
      body: Column(
        children: <Widget>[
          Text('侧滑删除'),
          Dismissible(
            onDismissed: (direction) {
              print(direction);
              return false;
            },
            background: Text('删除'),
            key: Key('1'),
            child: getDeleteItem(),
          )
        ]
      )
    );
  }



  Widget getDeleteItem() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFFF0000), width: 0.5)
      ),
      child: Text('我是购物车数据'),
    );
  }
  
}