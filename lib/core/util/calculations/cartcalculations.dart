import 'package:flutter/material.dart';

import '../../../feautures/grocbay_pos/domain/entities/cart_item_modle.dart';

class CartCalculationsState {
  double tax = 0.0;
  double discount = 0.0;
  double grandTotal = 0.0;
  double totalbalance = 0.0;
  double totalMRP = 0.0;

 String calculateTotalTax(List<CartItemModel> prod){
    tax=0.0;
    prod.forEach((element) {
      if(element.tax!.toString() != "null") {
       // print("list element passed to calculations "+element.tax!.toString());
        tax = tax + double.parse(element.tax!);
      }
     // print("sales Tax of element"+element.salesTax!.toString());

    });
   // print("tax"+tax.toString());
    return tax.toString();

  }

 String calculateTotalDiscount(List<CartItemModel> prod, bool membership){
    double tempregularprice = 0.0; //mrp
    double tempsaleprice = 0.0;   //price
    double    tempmembershipprice = 0;   //membershipprice
    discount=0.0;

    prod.forEach((element) {
      if (double.tryParse(element.varMrp!) == null) {
           tempregularprice = 0.0;
      }
      else{
          tempregularprice = double.parse(element.varMrp!)*(element.quantity??1).toInt();
      }

      if (double.tryParse(element.price!) == null || (element.price! == '-') || (element.price! == '')) {
        tempsaleprice = 0.0;
      }
      else{
        tempsaleprice = double.parse(element.price!)*(element.quantity??1).toInt();
      }

      if ((element.membershipPrice! == null || (element.membershipPrice! == '-') || (element.membershipPrice! == ''))) {
        tempmembershipprice = 0.0;
      } else{
        if(membership) {
          tempmembershipprice = double.parse(element.membershipPrice!)*(element.quantity??1).toInt();
        }
      }
      //print("regular,sales,membership price "+element.varMrp.toString()+" &"+element.salePrice.toString()+" &"+element.priceVariation![0].membershipPrice.toString());

      if(tempmembershipprice == 0){
       // print("membership 0 case "+tempmembershipprice.toString());
        discount = discount +  (tempregularprice - tempsaleprice);
       // print("discount "+discount.toString());


      }
      if (tempmembershipprice > 0 )
      {
        //print("membership >0 case "+tempmembershipprice.toString());
        discount = discount + (tempregularprice - tempmembershipprice);
        //print("discount "+discount.toString());

      }
    });
    //print("Discount"+discount.toString());
    return discount.toStringAsFixed(2);
  }

  calculateTotalAmount(List<CartItemModel> prod,bool isUserMember){

  double tempTotal=0.0;
   grandTotal=0.0;

  prod.forEach((element) {
    /*if(double.parse(element.membershipPrice!) == 0 || element.membershipPrice=='' || element.membershipPrice == '-'){
      tempTotal = tempTotal + double.parse(calculateTotalBalance(element.quantity!, double.parse(element.price!))) ;
    }
    if(double.parse(element.membershipPrice!) > 0){
      tempTotal = tempTotal + double.parse(calculateTotalBalance(element.quantity!, double.parse(element.membershipPrice!)));
    }*/
    tempTotal = tempTotal + double.parse(calculateTotalBalance(element.quantity!, double.parse(element.price!))) ;

    grandTotal =  tempTotal ;
  });

 // print("gtax"+tax.toString());
 //  print("gdiscount"+discount.toString());
 //  print("gtotal"+grandTotal.toString());
print("grand total $grandTotal}");
   return grandTotal.toStringAsFixed(2);
  }

  calculateTotalBalance(double qty,double balenc){
    totalbalance =0;
   totalbalance = (qty).toDouble() * (balenc).toDouble();

   return totalbalance.toStringAsFixed(2);
  }

  String calculateTotalMRP( List<CartItemModel> prod){
    totalMRP =0;
    prod.forEach((element) {
      // print((element.varMrp!*element.quantity!).toString());
      if(element.varMrp!.toString()!= "null") {
       // print("varMRP of list element passed to calculations ${(element.varMrp!*element.quantity!)}");
        totalMRP = totalMRP + double.parse(element.varMrp!)*element.quantity!;
      }
      // print("sales Tax of element"+element.salesTax!.toString());

    });
   // print("totalMRP"+totalMRP.toString());
    return totalMRP.toStringAsFixed(2);
  }

  calculateDeliveryCharge(List<CartItemModel> prod){
    totalMRP = 0;
    prod.forEach((element) {
      //print(element.deliv.toString());
      if(element.varMrp!.toString()!= "null") {
      //  print("varMRP of list element passed to calculations "+element.varMrp!.toString());
        totalMRP = totalMRP + double.parse(element.varMrp!);
      }


    });
    return totalMRP.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
