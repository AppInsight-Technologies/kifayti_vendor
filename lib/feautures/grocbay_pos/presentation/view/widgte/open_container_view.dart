import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerView extends StatelessWidget {
  final Widget Function(BuildContext, void Function({Object? returnValue})) openBuilder;
  final Widget child;
  const OpenContainerView({Key? key, required this.openBuilder, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Colors.transparent,
      useRootNavigator: false,

      openShape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      transitionDuration: Duration(seconds: 1),
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context,action)=> child, openBuilder: openBuilder,
    );
  }
}
