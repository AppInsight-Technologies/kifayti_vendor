import 'package:flutter/cupertino.dart';

import '../../../../feautures/grocbay_pos/domain/usecases/VendorProduct_usecase.dart';


class AddProductController {
  // int? item_active;
  // int? quantity_data;
  // String? item_name;
  // String? item_name_hindi;
  // String? stock_type;
  // String? delivery_duration;
  // int? product_type;
  // String? stock_notify;
  // String? return_duration;
  // String? tax;
  // String? express_eligible;
  // String? item_description;
  // String? manufacturer_description;
  // String? item_priority;
  // String? country_of_origin;
  // String? subscription_product;
  // String? vendor;
  // String? category;
  // String? brand;
  // String? veg_type;
  // List<Variation>? variations = [];
  int? branch;
  int? user;
  int? branchtype;
  String? replacementitems;
  String? itemName;
  int? type;
  String? nested;
  String? vegType;
  int? alert;
  int? duration;
  int? salesTax;
  String? itemDescription;
  String? itemShortDescription;
  int? itemPriority;
  String? country;
  int? isSubscription;
  int? mode;
  String? tags;
  int? brand;
  Null? nToken;
  String? userType;
  String? delivery;
  int? isActive;
  int? subscriptionModule;
  int? subscription;
  int? seller;
  int? b2bModule;
  String? quantityData;
  int? productType;
  String? singleSku;
  String? singleNetweight;
  String? singleBarcode;
  String? singleLoyalty;
  String? singleMinItem;
  String? singleMaxItem;
  String? singleUnit;
  String? singleIncrementVal;
  String? fishprice;
  String? singleMrp;
  String? singleSellingPrice;
  String? singleMembershipPrice;
  String? singleHsn;
  String? singleshortNote;
  String? topping;
  List<Variation>? variation;

  AddProductController(
      {this.branch,
        this.user,
        this.branchtype=4,
        this.replacementitems,
        this.itemName,
        this.type,
        this.nested,
        this.vegType,
        this.alert,
        this.duration,
        this.salesTax,
        this.itemDescription,
        this.itemShortDescription,
        this.itemPriority,
        this.country,
        this.isSubscription,
        this.mode,
        this.tags,
        this.brand,
        this.nToken,
        this.userType,
        this.delivery,
        this.isActive,
        this.subscriptionModule,
        this.subscription,
        this.seller,
        this.b2bModule,
        this.quantityData="0",
        this.productType,
        this.singleSku="0",
        this.singleNetweight="0",
        this.singleBarcode="0",
        this.singleLoyalty="0",
        this.singleMinItem="0",
        this.singleMaxItem="0",
        this.singleUnit="0",
        this.singleIncrementVal="0",
        this.fishprice="0",
        this.singleMrp="0",
        this.singleSellingPrice="0",
        this.singleMembershipPrice="0",
        this.singleHsn="0",
        this.singleshortNote="0",
        this.topping="0",
        this.variation});
}

// class VariationsList{
//    String? variationname;
//    String? unit;
//    String? priority;
//    String? sku;
//    String? hsn;
//    String? barcode;
//    String? loyalty_points;
//    String? gross_weight;
//    String? min_order_qty;
//    String? max_order_qty;
//    String? min_max_expiry;
//    String? price_per_unit;
//    String? actual_price;
//    String? discounted_price;
//    String? membership_price;
//    String? stock;
//
//
//    String? get var_name {
//      return variationname;
//    }
//     set set_var_name(value){
//      variationname = value;
//    }
//
//
//
//    }
// class Variations {
//   String? name;
//   String? price;
//   String? mrp;
//   int? priority;
//   int? min;
//   int? max;
//   int? membership;
//   int? barcode;
//   int? sku;
//   int? hsn;
//   int? weight;
//   int? loyalty;
//   int? cost;
//   int? netWeight;
//   int? unit;
//   int? status;
//   int? cartexpiry;
//   int? quantity;
//   int? wholesale;
//   int? priceperunit;
//   String? addon;
//   String? varnamesdata;
//   String? varlanguagedata;
//   String? unitsdata;
//   String? unitlanguagedata;
//   String? itemnames;
//   String? language;
//   String? desc;
//   String? languagedata;
//   String? manufacturedesc;
//   String? manifacturelanguagedata;
//   String? category;
//   int? brand;
//
//   Variations(
//       {this.name,
//         this.price,
//         this.mrp,
//         this.priority,
//         this.min,
//         this.max,
//         this.membership,
//         this.barcode,
//         this.sku,
//         this.hsn,
//         this.weight,
//         this.loyalty,
//         this.cost,
//         this.netWeight,
//         this.unit,
//         this.status,
//         this.cartexpiry,
//         this.quantity,
//         this.wholesale,
//         this.priceperunit,
//         this.addon,
//         this.varnamesdata,
//         this.varlanguagedata,
//         this.unitsdata,
//         this.unitlanguagedata,
//         this.itemnames,
//         this.language,
//         this.desc,
//         this.languagedata,
//         this.manufacturedesc,
//         this.manifacturelanguagedata,
//         this.category,
//         this.brand});
//
//
// }
