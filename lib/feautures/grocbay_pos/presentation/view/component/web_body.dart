import 'package:flutter/material.dart';

class WebBody extends StatefulWidget {
  final Widget? sidedrawer;
  final Widget body;

  const WebBody({Key? key, this.sidedrawer,required this.body}) : super(key: key);

  @override
  _WebBodyState createState() => _WebBodyState();
}

class _WebBodyState extends State<WebBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(children: [
        Container(child: widget.sidedrawer),
        Expanded(child: widget.body)
      ],),
    );
  }
}
