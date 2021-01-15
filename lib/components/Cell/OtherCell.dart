import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';



class OtherCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: 40,
      child: ListTile(
        title: Row(
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
        trailing: Icon(
          Icons.navigate_next
        )
      )
    );
  } 
}