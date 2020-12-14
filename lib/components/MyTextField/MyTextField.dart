import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  TextEditingController  controller;
  String placeholder;
  Function onSubmitted;
  TextInputAction textInputAction;


  MyTextField({ this.controller, this.placeholder = '请输入...', this.onSubmitted, this.textInputAction });



  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: TextField(
        controller: controller,
        maxLines: 1,
        textInputAction: textInputAction ?? TextInputAction.none,
        decoration: InputDecoration(
          counterText: '',
          hintText: placeholder,
          focusedBorder: OutlineInputBorder( borderSide: BorderSide(width:0, color: Colors.transparent)),
          disabledBorder: OutlineInputBorder( borderSide: BorderSide(width:0, color: Colors.transparent)),
          enabledBorder: OutlineInputBorder( borderSide: BorderSide(width:0, color: Colors.transparent)),
          border: OutlineInputBorder( borderSide: BorderSide(width:0, color: Colors.transparent)),
          contentPadding: EdgeInsets.symmetric(vertical:0)
        ),
        onSubmitted: onSubmitted ?? () {},
      )
    );
  }
  
}