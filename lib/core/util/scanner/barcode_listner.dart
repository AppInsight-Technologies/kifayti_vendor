import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
class BarCodeListner extends StatelessWidget {

  const BarCodeListner({Key? key, required this.listen, required this.child, this.usekey}) : super(key: key);
  final dynamic Function(String) listen;
  final Widget child;
  final bool? usekey;
  @override
  Widget build(BuildContext context) {
    debugPrint("barcode listener....");
    return BarcodeKeyboardListener(
      bufferDuration: Duration(milliseconds: 200),
      onBarcodeScanned: (barcode) =>listen(barcode),
      useKeyDownEvent: usekey!,
      child: child,
    );
  }
}
