import 'package:flutter/cupertino.dart';
// import '../..//feautures/grocbay_pos/domain/entities/fetch_category_product.dart';
import 'package:intl/intl.dart';

import 'fetch_category_product.dart';
class CartItemModel {
  String? id;
  String? eligibleForExpress;
  String? user;
  String? varId;
  double? quantity;
  String? createdDate;
  String? time;
  String? price;
  String? status;
  String? branch;
  String? itemId;
  String? varName;
  String? varMinItem;
  String? varMaxItem;
  String? itemLoyalty;
  String? varStock;
  String? varMrp;
  String? itemName;
  String? membershipPrice;
  String? itemActualprice;
  String? itemImage;
  String? membershipId;
  String? mode;
  String? type;
  String? vegType;
  String? note;
  String? weight;
  String? tax;
  String? skutype;
  String? unit;


  CartItemModel(
      {this.id,
        this.eligibleForExpress,
        this.user,
        this.varId,
        this.quantity,
        this.createdDate,
        this.time,
        this.price,
        this.status,
        this.branch,
        this.itemId,
        this.varName,
        this.varMinItem,
        this.varMaxItem,
        this.itemLoyalty,
        this.varStock,
        this.varMrp,
        this.itemName,
        this.membershipPrice,
        this.itemActualprice,
        this.itemImage,
        this.membershipId,
        this.mode,
        this.type,
        this.vegType,
        this.note,
        this.weight,
        this.tax,
        this.skutype,
        this.unit
      });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    debugPrint("json['unit'].toString()..."+json['varName'].toString());
    id = json['id'];
    eligibleForExpress = json['eligible_for_express'];
    user = json['user'];
    varId = json['var_id'];
    quantity = (json['quantity'] as num).toDouble();
    createdDate = json['created_date'];
    time = json['time'];
    price = json['price'];
    status = json['status'];
    branch = json['branch'];
    itemId = json['itemId'];
    varName = json['varName'];
    varMinItem = json['varMinItem'];
    varMaxItem = json['varMaxItem'];
    itemLoyalty = json['itemLoyalty'];
    varStock = json['varStock'];
    varMrp = json['varMrp'];
    itemName = json['itemName'];
    membershipPrice = json['membershipPrice'];
    itemActualprice = json['itemActualprice'];
    itemImage = json['itemImage'];
    membershipId = json['membershipId'];
    mode = json['mode'];
    type = json['type'];
    weight = json['weight'];
    vegType = json['veg_type'];
    note = json['note'];
    tax = json['tax'].toString();
    skutype = json['type'].toString();
    unit = json['unit'].toString();
  }

  Map<String, dynamic> toJson({String? user}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eligible_for_express'] = this.eligibleForExpress;
    data['user'] = user?? this.user;
    data['var_id'] = this.varId;
    data['quantity'] = this.quantity;
    data['created_date'] = this.createdDate;
    data['time'] = this.time;
    data['price'] = this.price;
    data['status'] = this.status;
    data['branch'] = this.branch;
    data['itemId'] = this.itemId;
    data['varName'] = this.varName;
    data['varMinItem'] = this.varMinItem;
    data['varMaxItem'] = this.varMaxItem;
    data['itemLoyalty'] = this.itemLoyalty;
    data['varStock'] = this.varStock;
    data['varMrp'] = this.varMrp;
    data['itemName'] = this.itemName;
    data['membershipPrice'] = this.membershipPrice;
    data['itemActualprice'] = this.itemActualprice;
    data['itemImage'] = this.itemImage;
    data['membershipId'] = this.membershipId;
    data['mode'] = this.mode;
    data['type'] = this.type;
    data['veg_type'] = this.vegType;
    data['weight'] = this.weight;
    data['note'] = this.note;
    data['tax'] = this.tax;
    data['type'] = this.skutype;
    data['unit'] = this.unit;
    return data;
  }
  CartItemModel.fromProduct(
      {required FetchCategoryProduct product, required double quantity, required String varid, required String u_id,required String branch, required ismembereduser}){
    print("varid: $varid");
    print("quantity: $quantity");
    final variation = product.priceVariation?.firstWhere((element) => element.id == varid);
    this.id = product.id;
    this.eligibleForExpress = product.eligibleForExpress;
    this.user = u_id;
    this.varId = varid;
    this.quantity = quantity;
    this.createdDate =  DateFormat('dd-MM-yyyy').format(DateTime.now());
    this.time = DateFormat('kk:mm').format(DateTime.now());
    this.varMrp = (variation?.mrp??product.mrp).toString();
    // String productprice = product.priceVariation!.firstWhere((element) => element.id == varid).price.toString();
   // final variationdata = product.priceVariation!.firstWhere((element) => element.id == varid);
  // this.price = ((ismembereduser==null||ismembereduser.toString()=="0")?variationdata.price:(variationdata.membershipPrice! > 0) ? variationdata.membershipPrice : variationdata.price).toString();
  //  print("membered_user value in cartitem model "+ismembereduser.toString());
    // if (ismembereduser.toString() == "0") {
    //   if (double.parse(productprice) <= 0 || productprice.toString() == "" || productprice == this.varMrp) {
    //     this.price = this.varMrp.toString();
    //   } else {
    //     this.price = productprice.toString();
    //   }
    // } else {
    //   if(double.parse(product.priceVariation!.firstWhere((element) => element.id == varid).membershipPrice.toString()) <= 0 || product.priceVariation!.firstWhere((element) => element.id == varid).membershipPrice.toString() == "" || double.parse(product.priceVariation!.firstWhere((element) => element.id == varid).membershipPrice.toString()) == this.varMrp.toString()) {
    //     this.price = this.varMrp.toString();
    //   } else {
    //     this.price = product.priceVariation!.firstWhere((element) => element.id == varid).membershipPrice.toString();
    //   }
    // }
    this.price = (product.priceVariation?.firstWhere((element) => element.id == varid).price??product.price).toString();//TODO: double check this
    this.status = product.priceVariation?.firstWhere((element) => element.id == varid).status??product.status;
    this.branch = branch;
    this.itemId = product.id;
    this.itemName = product.itemName;
    this.varName = variation?.variationName??product.itemName;
    this.varMinItem = variation?.minItem??product.minItem.toString();
    this.varMaxItem = variation?.maxItem??product.maxItem.toString();
    this.itemLoyalty = (variation?.loyalty??product.loyalty).toString();
    this.varStock = (variation?.stock??product.stock).toString();
    this.varName = (variation?.variationName??product.itemName).toString();
    this.membershipPrice = (variation?.membershipPrice??product.membershipPrice).toString();
    this.itemActualprice = (variation?.price??product.price).toString();
    this.itemImage = product.itemFeaturedImage;
    this.membershipId = "0";
    this.mode = "0";
    //this.type = "kg";
    this.type = (variation?.unit??product.unit);
    this.note = "";
    this.weight = product.weight;
    this.tax = product.salesTax.toString();
    this.skutype = product.type;
    this.unit = (variation?.unit??product.unit);


  }
}