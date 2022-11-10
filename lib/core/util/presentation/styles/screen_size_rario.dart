
import 'package:flutter/material.dart';

class LayoutView{
  BuildContext context;
  LayoutView(this.context);
  bool get isMobile =>MediaQuery.of(context).size.width<610;
  bool get isWeb =>MediaQuery.of(context).size.width>880;
  bool get isTab =>MediaQuery.of(context).size.width>610&&MediaQuery.of(context).size.width<880;
}