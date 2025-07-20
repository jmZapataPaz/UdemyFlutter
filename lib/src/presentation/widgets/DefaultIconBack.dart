import 'package:flutter/material.dart';

class DefaultIconBack extends StatelessWidget {
  double left;
  double top;
  Color color = Colors.white;
  
  DefaultIconBack({
    required this.left,
    required this.top,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: top, left: left),
      child: IconButton(
        onPressed: (){Navigator.pop(context);}, 
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 40,
          color: color,
        )
      ),
    );
  }
}