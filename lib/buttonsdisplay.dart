// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final buttontext;
  final buttoncolor;
  final textcolor;
  final buttontapped;
  MyButton(
      {this.buttontext, this.buttoncolor, this.buttontapped, this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: buttontapped,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            alignment: Alignment.center,
            color: buttoncolor,
            child: Text(
              buttontext,
              style: TextStyle(fontSize: 24.0, color: textcolor),
            ),
          ),
        ),
      ),
    );
  }
}
