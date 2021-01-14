import 'package:flutter/material.dart';
import 'package:app/components/Cell/MyCell.dart';
import 'package:app/components/Cell/OtherCell.dart';

class CellPage extends StatefulWidget {
  _CellPage createState() => _CellPage();
}

class _CellPage extends State<CellPage> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单元格')
      ),
      body: Column(
        children: [
          Text('基础用法'),
          MyCell(),
          Text('用listtile写出来的cell'),
          OtherCell()
        ]
      )
    );
  }
}