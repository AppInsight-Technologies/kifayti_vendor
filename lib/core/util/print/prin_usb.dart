import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
// import '../..//feautures/grocbay_pos/domain/entities/cart_item_modle.dart';
// import '../..//feautures/grocbay_pos/domain/entities/get_profile_modle.dart';
// import '../..//feautures/grocbay_pos/domain/usecases/check_out_usecase.dart';

import '../../../feautures/grocbay_pos/domain/entities/cart_item_modle.dart';
import '../../../feautures/grocbay_pos/domain/entities/get_profile_modle.dart';
import '../../../feautures/grocbay_pos/domain/entities/update_order_model.dart';
import '../../../feautures/grocbay_pos/domain/usecases/check_out_usecase.dart';
import '../calculations/cartcalculations.dart';

class UsbPrinter{
  final FlutterUsbPrinter flutterUsbPrinter ;
 const UsbPrinter(this.flutterUsbPrinter);
  Future<List<int>> _testTicket(OrderItem odata, List<CartItemModel> list_cart_items, GetCustomerProfile user, String waletamt) async{
    // final List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    CartCalculationsState cal = CartCalculationsState();

    bytes += generator.text('InstaBasket',
        styles: const PosStyles(
            bold: true,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            align: PosAlign.center
        ));
    bytes += generator.text('Main Road, near Pragathi Speciality Hospital, \n Bolwar, Puttur, Karnataka 574201', styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text("GST NO: -",styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text("Mobile: +91 84534 05995",styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text("Email : invoice@ibstores.in",styles: const PosStyles(align: PosAlign.center), linesAfter: 2);
    bytes += generator.text('Bill To / Ship To',
        styles: const PosStyles(
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));
    bytes += generator.text('${user.data!.first.username}');
   // bytes += generator.text('${odata.address}',);
    bytes += generator.text('Mobile : ${user.data!.first.mobileNumber}',);
    debugPrint("user.data!.first.email...."+user.data!.first.email!);
    if(user.data!.first.email == " " ||  user.data!.first.email == "") {}else{
      debugPrint("user.data!.first.email....1.."+user.data!.first.email!);
      bytes += generator.text('Email : ${user.data!.first.email}');
    }
    bytes += generator.text('Invoice Number : ${odata.id}');
    bytes += generator.text('Order Date: ${odata.orderDate}',);
 //   bytes += generator.text('Slot: 2020',);
   // bytes += generator.text('Order Type : POS', linesAfter: 1);
    bytes += generator.row([
      PosColumn(text: "Item Name",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "Price",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "Qty",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "amount",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
    ]);
    list_cart_items.forEach((element) {
      bytes += generator.row([
        PosColumn(text: "${element.itemName}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "${element.varMrp}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "${element.quantity}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "${(element.quantity??1)*(double.parse(element.varMrp!))}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      ]);
    });
    bytes += generator.emptyLines(1);
    bytes += generator.row([
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "MRP: ",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: cal.calculateTotalMRP(list_cart_items),width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1),),
    ]);
    if(double.parse(odata.loyalty??'0')>0) {
      bytes += generator.row([
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "loyalty",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: odata.loyalty??"0",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
    ]);
    }
    if(double.parse(cal.calculateTotalDiscount(list_cart_items, user.data?.first.membership == "1"))>0) {
      bytes += generator.row([
        PosColumn(text: "",
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
        PosColumn(text: "",
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
        PosColumn(text: "promo",
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
        PosColumn(text: cal.calculateTotalDiscount(
            list_cart_items, user.data?.first.membership == "1"),
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
      ]);
    }
    if(double.parse(cal.calculateTotalDiscount(list_cart_items,user.data?.first.membership=="1"))>0) {
      bytes += generator.row([
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "You Saved ",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1,bold: true)),
      PosColumn(text: cal.calculateTotalDiscount(list_cart_items,user.data?.first.membership=="1"),width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1,bold: true)),
    ]);
    }
    bytes += generator.emptyLines(1);

    bytes += generator.text('Amount Payable ${ double.parse(cal.calculateTotalMRP(list_cart_items))-double.parse(cal.calculateTotalDiscount(list_cart_items,user.data?.first.membership=="1")) }',
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    if(double.parse(waletamt)>0) {
      bytes += generator.text('wallet payment : $waletamt',linesAfter: 3);
    }
    bytes += generator.text("thank you for shopping with InstaBasket ",styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return Future.value(bytes);
  }

  Future<List<int>> _testTicketOrder(UpdateOrderModel odata) async{
    // final List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    CartCalculationsState cal = CartCalculationsState();

    debugPrint("odata.id..."+odata.id!);

    bytes += generator.text('InstaBasket',
        styles: const PosStyles(
            bold: true,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            align: PosAlign.center
        ));
    bytes += generator.text('Main Road, near Pragathi Speciality Hospital, \n Bolwar, Puttur, Karnataka 574201', styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text("GST NO: -",styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text("Mobile: +91 84534 05995",styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text("Email : invoice@ibstores.in",styles: const PosStyles(align: PosAlign.center), linesAfter: 2);
    bytes += generator.text('Order Details',
        styles: const PosStyles(
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));
    bytes += generator.text('${odata.customerName}');
    bytes += generator.text('Invoice Number : ${odata.id}');
    bytes += generator.text('Order Date: ${odata.orderDate}',);
    //   bytes += generator.text('Slot: 2020',);
    // bytes += generator.text('Order Type : POS', linesAfter: 1);
    bytes += generator.row([
      PosColumn(text: "Item Name",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "Price",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "Qty",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "amount",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
    ]);
    odata.items?.forEach((element) {
      bytes += generator.row([
        PosColumn(text: "${element.itemName}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "${element.mrp}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "${element.quantity}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "${(double.parse(element.quantity!))*(element.mrp!)}",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      ]);
    });
    bytes += generator.emptyLines(1);
    bytes += generator.row([
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: "MRP: ",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      PosColumn(text: odata.orderAmount!,width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1),),
    ]);
    if(odata.loyalty! > 0) {
      bytes += generator.row([
        PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "loyalty",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: odata.loyalty.toString(),width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
      ]);
    }
    if(double.parse(odata.promocode! )>0) {
      bytes += generator.row([
        PosColumn(text: "",
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
        PosColumn(text: "",
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
        PosColumn(text: "promo",
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
        PosColumn(text: odata.promocode!,
            width: 3,
            styles: const PosStyles(
                width: PosTextSize.size1, height: PosTextSize.size1)),
      ]);
    }
    if((double.parse(odata.membershipEarned.toString()) + double.parse(odata.promocodeDiscount.toString()))>0) {
      bytes += generator.row([
        PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1)),
        PosColumn(text: "You Saved ",width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1,bold: true)),
        PosColumn(text: (double.parse(odata.membershipEarned.toString()) + double.parse(odata.promocodeDiscount.toString())).toString(),width: 3,styles: const PosStyles(width: PosTextSize.size1,height: PosTextSize.size1,bold: true)),
      ]);
    }
    bytes += generator.emptyLines(1);

    bytes += generator.text('Total Amount ${ odata.orderAmount }',
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    if(double.parse(odata.wallet.toString())>0) {
      bytes += generator.text('wallet payment : ${odata.wallet}',linesAfter: 3);
    }
    bytes += generator.text("thank you for shopping with InstaBasket ",styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return Future.value(bytes);
  }


  print(OrderItem odata, List<CartItemModel> list_cart_items, GetCustomerProfile user, String waletamt) async {
    try {
      var bytes = await _testTicket(odata,list_cart_items,user,waletamt);
      Uint8List data = Uint8List.fromList(bytes);
      final status =  await flutterUsbPrinter.write(data);
      if(status??false){}else{}
    } catch(e) {}
  }

  printPosOrder(UpdateOrderModel odata) async {
    try {
      var bytes = await _testTicketOrder(odata);
      Uint8List data = Uint8List.fromList(bytes);
      final status =  await flutterUsbPrinter.write(data);
      if(status??false){}else{}
    } catch(e) {}
  }

 Future<List<Map<String, dynamic>>> getDevicelist()  => FlutterUsbPrinter.getUSBDeviceList();
  Future<bool> connect(int vendorId, int productId) async {
    try { return Future.value(await flutterUsbPrinter.connect(vendorId, productId));
    } on PlatformException {
      return Future.value(false);
    }
  }
}
