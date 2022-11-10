import 'package:flutter/material.dart';

class CCardView extends StatelessWidget {
  final Widget child;
  const CCardView({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 2,child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(elevation: 4,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),child:child),
    ));
  }
}