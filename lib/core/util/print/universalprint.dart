// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' if (dart.library.io) 'package:flutter/material.dart'as pw;
// import 'package:printing/printing.dart';
// import 'dart:ui' as ui;
// // import 'package:flutter/material.dart' as mt;
// import '../../../feautures/grocbay_pos/domain/entities/cart_item_modle.dart';
// import '../../../feautures/grocbay_pos/domain/entities/get_profile_modle.dart';
// import '../../../feautures/grocbay_pos/domain/usecases/check_out_usecase.dart';
// import '../calculations/cartcalculations.dart';
// class UniversalPrint{
//   OrderItem items;
//   GetCustomerProfile user;
//   List<CartItemModel> cartlist = [];
//   CartCalculationsState cal = new CartCalculationsState();
//   final fontssize = 12.0;
//   final GlobalKey genKey = GlobalKey();
//
//   var shopname = "Insta Basket";
//   UniversalPrint(this.user,this.items,this.cartlist);
//   Future<Uint8List> generatePdf(PdfPageFormat format) async {
//     final image = await imageFromAssetBundle('assets/images/logo.png');
//
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     final font = await PdfGoogleFonts.juliusSansOneRegular();
//
//     pdf.addPage(
//       _PDFPage(format,  font,image),
//     );
//
//     return pdf.save();
//   }
//   print() async {
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     final font = await PdfGoogleFonts.nunitoExtraLight();
//     final image = await imageFromAssetBundle('assets/images/logo.png');
//     await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
//       pdf.addPage(
//         _PDFPage(format,  font,image),
//       );
//       return pdf.save();
//     });
//   }
//   Future<void> takePicture() async {
//     RenderRepaintBoundary boundary = genKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage();
//     // final directory = (await getApplicationDocumentsDirectory()).path;
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List();
//
//     // File imgFile = File('$directory/photo.png');
//     // imgFile.writeAsBytes(pngBytes);
//   }
//   pw.Page _PDFPage(PdfPageFormat format,  pw.Font font, pw.ImageProvider logo) {
//     // final fbody = await PdfGoogleFonts.barlowBlack();
//     const borderWidth = 0.3;
//     const fontssize = 12.0;
//     return pw.Page(
//       pageFormat: PdfPageFormat.roll80,
//       build: (context) {
//         return pw.Column(
//           // crossAxisAlignment: pw.CrossAxisAlignment.end,
//           children: [
//             pw.Image(logo,height: 80,width: 80),
//             pw.Text(shopname, style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold,fontSize: 16)),
//             pw.Text("${items.id}", style: pw.TextStyle(font: font,fontSize: 16)),
//
//             pw.Column(mainAxisSize: pw.MainAxisSize.min,crossAxisAlignment: pw.CrossAxisAlignment.stretch,children: [
//               // pw.Expanded(flex: 3,child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start,children: [
//               //   pw.Text("Bill to/ Ship to",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//               //   pw.Text("${items.customerName}", style: const pw.TextStyle(fontSize: fontssize)),
//               //   pw.Text("${items.address}", style: const pw.TextStyle(fontSize: fontssize)),
//               //   // pw.Text("Maharastra 412105,india", style: const pw.TextStyle(fontSize: fontssize)),
//               //   pw.Text("Mobile: ${user.data!.first.mobileNumber}", style: const pw.TextStyle(fontSize: fontssize)),
//               //   pw.Text("Email: ${user.data!.first.email}", style: const pw.TextStyle(fontSize: fontssize)),
//               //   pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10),child:  _oderDetailsTable(borderWidth,{
//               //       "Order id":" ${items.id}",
//               //     "Invoice Id":"${items.invoice}",
//               //     "Order Date":"${items.orderDate}",
//               //     "Slot":"2022",
//               //     "Order Type":"POS",
//               //   })),
//               // ])),
//               // pw.Text("A to Z ",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//               // pw.Text("A to Z SuperMarket",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.normal)),
//               pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center,children: [
//                 pw.Text("Puttur",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//                 // pw.Text("GST NO: 29BMDPK6598R1ZU",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//                 pw.Text("Mobile: +91 84534 05995",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//                 pw.Text("Email : info@instabasket.in",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//               ]),
//               pw.Divider(),
//               pw.SizedBox(height: 10),
//               pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start,children: [
//                 // pw.Text("Bill to/ Ship to",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 4),
//                 pw.Text("${user.data!.first.username}", style:  pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//                 pw.Text(user.data?.first.billingAddress?.first.address??"", style:  pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//                 // pw.Text("Maharastra 412105,india", style: const pw.TextStyle(fontSize: fontssize)),
//                 pw.Text("Mobile: ${user.data!.first.mobileNumber}", style:  pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//                 pw.Text("Email: ${user.data!.first.email}", style:  pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//                 pw.Text("Order Date :${items.orderDate}",style: pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//                 pw.Text("Slot : 2022",style: pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//                 pw.Text("Order Type : POS",style: pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//                 // pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10),child:  _oderDetailsTable(borderWidth,{
//                 //   "Order id":" ${items.id}",
//                 //   "Invoice Id":"${items.invoice}",
//                 //   "Order Date":"${items.orderDate}",
//                 //   "Slot":"2022",
//                 //   "Order Type":"POS",
//                 // })),
//               ]),
//               pw.Divider(),
//               // pw.Expanded(flex: 1,child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start,children: [
//               //   pw.SizedBox(
//               //     width: 30,
//               //     child: pw.FittedBox(
//               //       child:pw.Flexible(child: pw.Image(logo)),
//               //     ),
//               //   ),
//               //   pw.Text("A to Z ",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),
//               //   pw.Text("A to Z SuperMarket",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.normal)),
//               //   pw.Text("No 2fontssize4b, 5th Main, K.R.Garden , Murugespalya , Bangalore\nOld Airport Road",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.normal)),
//               //   pw.Text("GST NO: 29BMDPK6598R1ZU",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.normal)),
//               //   pw.Text("Mobile: 9845915835",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.normal)),
//               //   pw.Text("Email : noreply@atozsupermarket.com",style: pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.normal)),
//               //
//               // ])),
//             ]),
//             pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10),child:  _itemDetailsTable(borderWidth,[
//               ...cartlist.map((e) =>  {
//                 // "sl_no": " ${cartlist.indexOf(e)+1}",
//                 "IItem Name": "${e.itemName}",
//                 // "HSN": "",
//                 "PRICE": "${double.parse(e.varMrp!)}",
//                 "Quantity": "${e.quantity}",
//                 // "TAX": "${e.tax}",
//                 "TOTAL VALUE": "${cal.calculateTotalBalance(e.quantity!, double.parse(e.varMrp!))}",
//               }),
//             ])),
//             pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 2),child:  _oderDetailsTable(borderWidth,{
//               "Total":" ${cal.calculateTotalMRP(cartlist)}",
//               // "Tax":" -",
//               "You Saved ":cal.calculateTotalDiscount(cartlist,false),
//               "Grand Total":"${cal.calculateTotalAmount(cartlist,false)}",
//             })),
//             pw.Text("You Saved ${cal.calculateTotalDiscount(cartlist,false)}",style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold)),
//             pw.Text("wallet payment: ${items.wallet} | Cash/Card/UPI ${items.orderAmount}",style: pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//             // pw.Flexible(child: pw.FlutterLogo())
//             pw.SizedBox(height: 50),
//             pw.Text("Thank you for ordering with $shopname",style: pw.TextStyle(fontSize: fontssize-2,fontWeight: pw.FontWeight.bold)),
//
//           ],
//         );
//       },
//     );
//   }
//   pw.Table _oderDetailsTable(double borderWidth,Map<String,String> datas) {
//     return pw.Table(tableWidth: pw.TableWidth.max,border: pw.TableBorder(
//         horizontalInside: pw.BorderSide(width: borderWidth),
//         verticalInside: pw.BorderSide(width: borderWidth),
//         top: pw.BorderSide(width: borderWidth),bottom: pw.BorderSide(width: borderWidth),
//         left: pw.BorderSide(width: borderWidth),right: pw.BorderSide(width: borderWidth)
//     ),
//         children: datas.entries.map((e) => pw.TableRow(children: [
//           pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 2,horizontal: 6),child: pw.Text(e.key, style:  pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),),
//           pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 2,horizontal: 6),child: pw.Text(e.value, style:  pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),)
//         ])).toList());
//   }
//   pw.Table _itemDetailsTable(double borderWidth,List<Map<String,String>> datas) {
//     return pw.Table(tableWidth: pw.TableWidth.max,border: pw.TableBorder(horizontalInside: pw.BorderSide(width: borderWidth),
//         verticalInside: pw.BorderSide(width: borderWidth),
//         top: pw.BorderSide(width: borderWidth),bottom: pw.BorderSide(width: borderWidth),left: pw.BorderSide(width: borderWidth),right: pw.BorderSide(width: borderWidth)),
//         children: [
//           pw.TableRow(children: datas.first.entries.map((e) => pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 2,horizontal: 6),child: pw.Text(e.key, style:  pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),)).toList()),
//           ...datas.map((e) => pw.TableRow(children: e.entries.map((e) => pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 6,horizontal: 6),child: pw.Text(e.value, style:  pw.TextStyle(fontSize: fontssize,fontWeight: pw.FontWeight.bold)),)).toList())).toList(),
//         ]);
//   }
// }
