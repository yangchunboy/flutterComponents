import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class MyCell extends StatelessWidget {

  String title;

  // MyCell({});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 12, right: 12),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(right: 5),
                  // child: Expanded(
                    child: Image.asset(Utils.getImageUrl('smile'))
                  // )
                ),
                Text('标题')
              ],
            ),
          ),
          Container(
            child: Icon(
              Icons.navigate_next
            )
          )
        ],
      ),
    );
  }
}