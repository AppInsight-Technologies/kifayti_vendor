import 'package:flutter/material.dart';

class CalenderViewButton extends StatelessWidget {
  const CalenderViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
        Text("06 January",textAlign:TextAlign.right,style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.bold)),
      ],
    );
  }
}
