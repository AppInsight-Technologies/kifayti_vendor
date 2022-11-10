import 'package:dartz/dartz.dart';
//import '../..//feautures/grocbay_pos/domain/entities/VendorProduct_model.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositorie/repository_provider.dart';

class VendorProductUsecase extends UseCase<bool, ProductAddParms> {
  DependencyRepostProvider repo;
  VendorProductUsecase(this.repo);

  @override
  Future<Either<Failure, bool>> call({ProductAddParms?  data}) async {
    // TODO: implement call
    print("Product parms:${data!.toJson()}");
    final value = await repo.getRequest(Params(
        uri: Uri.parse("pos-add-item"),
        methed: Methed.Post,
        data: data.toJson()));

    return Future.value(
        value.fold((l) => Left(l), (r) => Right(r == "New Item Added!")));
  }
}

// class ProductAddParms {
//   String? branch;
//   String? user;
//   int? branchtype;
//   String? replacementitems;
//   String? itemName;
//   int? type;
//   String? nested;
//   String? vegType;
//   int? alert;
//   int? duration;
//   int? salesTax;
//   String? itemDescription;
//   String? itemShortDescription;
//   int? itemPriority;
//   String? country;
//   int? isSubscription;
//   int? mode;
//   String? tags;
//   int? quantity_data;
//   int? brand;
//   String? sToken;
//   String? userType;
//   String? delivery;
//   int? isActive;
//   int? subscriptionModule;
//   int? subscription;
//   int? seller;
//   int? b2bModule;
//   int? quantityData;
//   int? productType;
//   String singleSku="0";
//   String singleNetweight="0";
//   String singleBarcode="0";
//   String singleLoyalty="0";
//   String singleMinItem="0";
//   String singleMaxItem="0";
//   String singleUnit="0";
//   String singleIncrementVal="0";
//   String? fishprice="0";
//   String  singleMrp="0";
//   String singleSellingPrice="0";
//   String singleMembershipPrice="0";
//   String singleHsn="0";
//   String singleshortNote="0";
//   String topping="0";
//   List<Variation>? variation;
//
//   ProductAddParms(
//       {
//         this.branch=" ",
//         this.user=" ",
//         this.branchtype=4,
//         this.replacementitems=" ",
//         this.itemName=" ",
//         this.type=0,
//         this.nested=" ",
//         this.vegType=" ",
//         this.alert=1,
//         this.duration=0,
//         this.salesTax=0,
//         this.itemDescription=" ",
//         this.itemShortDescription=" ",
//         this.itemPriority=0,
//         this.country=" ",
//         this.isSubscription=0,
//         this.mode=0,
//         this.tags=" ",
//         this.quantity_data=0,
//         this.brand=0,
//         this.sToken=" ",
//         this.userType=" ",
//         this.delivery=" ",
//         this.isActive=0,
//         this.subscriptionModule=0,
//         this.subscription=0,
//         this.seller=0,
//         this.b2bModule=0,
//         this.quantityData=0,
//         this.productType=0,
//         this.singleSku=" ",
//         this.singleNetweight="0",
//         this.singleBarcode="0",
//         this.singleLoyalty="0",
//         this.singleMinItem="0",
//         this.singleMaxItem="0",
//         this.singleUnit="0",
//         this.singleIncrementVal="0",
//         this.fishprice="0",
//         this.singleMrp="0",
//         this.singleSellingPrice="0",
//         this.singleMembershipPrice="0",
//         this.singleHsn="0",
//         this.singleshortNote="0",
//         this.topping="0",
//         this.variation
//       });
//
//   ProductAddParms.fromJson(Map<String, dynamic> json) {
//     branch = json['branch'];
//     user = json['user'];
//     branchtype = json['branchtype'];
//     replacementitems = json['replacementitems'];
//     itemName = json['itemName'];
//     type = json['type'];
//     nested = json['nested'];
//     vegType = json['vegType'];
//     alert = json['alert'];
//     duration = json['duration'];
//     salesTax = json['salesTax'];
//     itemDescription = json['itemDescription'];
//     itemShortDescription = json['itemShortDescription'];
//     itemPriority = json['itemPriority'];
//     country = json['country'];
//     isSubscription = json['isSubscription'];
//     mode = json['mode'];
//     tags = json['tags'];
//     brand = json['brand'];
//     sToken = json['_token'];
//     userType = json['userType'];
//     delivery = json['delivery'];
//     isActive = json['isActive'];
//     subscriptionModule = json['subscriptionModule'];
//     subscription = json['subscription'];
//     seller = json['seller'];
//     b2bModule = json['b2bModule'];
//     quantityData = json['quantity_data'];
//     productType = json['productType'];
//     singleSku = json['singleSku'];
//     singleNetweight = json['singleNetweight'];
//     singleBarcode = json['singleBarcode'];
//     singleLoyalty = json['singleLoyalty'];
//     singleMinItem = json['singleMinItem'];
//     singleMaxItem = json['singleMaxItem'];
//     singleUnit = json['singleUnit'];
//     singleIncrementVal = json['singleIncrementVal'];
//     fishprice = json['fishprice'];
//     singleMrp = json['singleMrp'];
//     singleSellingPrice = json['singleSellingPrice'];
//     singleMembershipPrice = json['singleMembershipPrice'];
//     singleHsn = json['singleHsn'];
//     singleshortNote = json['singleshortNote'];
//     topping = json['topping'];
//     if (json['variation'] != null) {
//       variation = <Variation>[];
//       json['variation'].forEach((v) {
//         variation!.add(new Variation.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['branch'] = this.branch;
//     data['user'] = this.user;
//     data['branchtype'] = this.branchtype;
//     data['replacementitems'] = this.replacementitems;
//     data['itemName'] = this.itemName;
//     data['type'] = this.type;
//     data['nested'] = this.nested;
//     data['vegType'] = this.vegType;
//     data['alert'] = this.alert;
//     data['duration'] = this.duration;
//     data['salesTax'] = this.salesTax;
//     data['itemDescription'] = this.itemDescription;
//     data['itemShortDescription'] = this.itemShortDescription;
//     data['itemPriority'] = this.itemPriority;
//     data['country'] = this.country;
//     data['isSubscription'] = this.isSubscription;
//     data['mode'] = this.mode;
//     data['tags'] = this.tags;
//     data['brand'] = this.brand;
//     data['_token'] = this.sToken;
//     data['userType'] = this.userType;
//     data['delivery'] = this.delivery;
//     data['isActive'] = this.isActive;
//     data['subscriptionModule'] = this.subscriptionModule;
//     data['subscription'] = this.subscription;
//     data['seller'] = this.seller;
//     data['b2bModule'] = this.b2bModule;
//     data['quantity_data'] = this.quantityData;
//     data['productType'] = this.productType;
//     data['singleSku'] = this.singleSku;
//     data['singleNetweight'] = this.singleNetweight;
//     data['singleBarcode'] = this.singleBarcode;
//     data['singleLoyalty'] = this.singleLoyalty;
//     data['singleMinItem'] = this.singleMinItem;
//     data['singleMaxItem'] = this.singleMaxItem;
//     data['singleUnit'] = this.singleUnit;
//     data['singleIncrementVal'] = this.singleIncrementVal;
//     data['fishprice'] = this.fishprice;
//     data['singleMrp'] = this.singleMrp;
//     data['singleSellingPrice'] = this.singleSellingPrice;
//     data['singleMembershipPrice'] = this.singleMembershipPrice;
//     data['singleHsn'] = this.singleHsn;
//     data['singleshortNote'] = this.singleshortNote;
//     data['topping'] = this.topping;
//     if (this.variation != null) {
//       data['variation'] = this.variation!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Variation {
//   String? variation_name;
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
//   String? unit;
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
//   Variation(
//       {this.variation_name = "",
//         this.price = "",
//         this.mrp = "",
//         this.priority = 0,
//         this.min = 1,
//         this.max = 1,
//         this.membership = 0,
//         this.barcode = 0,
//         this.sku = 1,
//         this.hsn = 1,
//         this.weight = 1,
//         this.loyalty = 0,
//         this.cost = 0,
//         this.netWeight = 0,
//         this.unit = "",
//         this.status = 0,
//         this.cartexpiry = 0,
//         this.quantity = 0,
//         this.wholesale = 0,
//         this.priceperunit = 0,
//         this.addon = "",
//         this.varnamesdata = "",
//         this.varlanguagedata = "",
//         this.unitsdata = "",
//         this.unitlanguagedata = "",
//         this.itemnames = "",
//         this.language = "",
//         this.desc = "",
//         this.languagedata = "",
//         this.manufacturedesc = "",
//         this.manifacturelanguagedata = "",
//         this.category = "",
//         this.brand = 0});
//
//   Variation.fromJson(Map<String, dynamic> json) {
//     variation_name = json['variation_name'];
//     price = json['price'];
//     mrp = json['mrp'];
//     priority = json['priority'];
//     min = json['min'];
//     max = json['max'];
//     membership = json['membership'];
//     barcode = json['barcode'];
//     sku = json['sku'];
//     hsn = json['hsn'];
//     weight = json['weight'];
//     loyalty = json['loyalty'];
//     cost = json['cost'];
//     netWeight = json['net_weight'];
//     unit = json['unit'];
//     status = json['status'];
//     cartexpiry = json['cartexpiry'];
//     quantity = json['quantity'];
//     wholesale = json['wholesale'];
//     priceperunit = json['priceperunit'];
//     addon = json['addon'];
//     varnamesdata = json['varnamesdata'];
//     varlanguagedata = json['varlanguagedata'];
//     unitsdata = json['unitsdata'];
//     unitlanguagedata = json['unitlanguagedata'];
//     itemnames = json['itemnames'];
//     language = json['language'];
//     desc = json['desc'];
//     languagedata = json['languagedata'];
//     manufacturedesc = json['manufacturedesc'];
//     manifacturelanguagedata = json['manifacturelanguagedata'];
//     category = json['category'];
//     brand = json['brand'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['variation_name'] = this.variation_name;
//     data['price'] = this.price;
//     data['mrp'] = this.mrp;
//     data['priority'] = this.priority;
//     data['min'] = this.min;
//     data['max'] = this.max;
//     data['membership'] = this.membership;
//     data['barcode'] = this.barcode;
//     data['sku'] = this.sku;
//     data['hsn'] = this.hsn;
//     data['weight'] = this.weight;
//     data['loyalty'] = this.loyalty;
//     data['cost'] = this.cost;
//     data['net_weight'] = this.netWeight;
//     data['unit'] = this.unit;
//     data['status'] = this.status;
//     data['cartexpiry'] = this.cartexpiry;
//     data['quantity'] = this.quantity;
//     data['wholesale'] = this.wholesale;
//     data['priceperunit'] = this.priceperunit;
//     data['addon'] = this.addon;
//     data['varnamesdata'] = this.varnamesdata;
//     data['varlanguagedata'] = this.varlanguagedata;
//     data['unitsdata'] = this.unitsdata;
//     data['unitlanguagedata'] = this.unitlanguagedata;
//     data['itemnames'] = this.itemnames;
//     data['language'] = this.language;
//     data['desc'] = this.desc;
//     data['languagedata'] = this.languagedata;
//     data['manufacturedesc'] = this.manufacturedesc;
//     data['manifacturelanguagedata'] = this.manifacturelanguagedata;
//     data['category'] = this.category;
//     data['brand'] = this.brand;
//     return data;
//   }
// }



class ProductAddParms {
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

  ProductAddParms(
      {this.branch,
        this.user,
        this.branchtype,
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

  ProductAddParms.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    user = json['user'];
    branchtype = json['branchtype'];
    replacementitems = json['replacementitems'];
    itemName = json['itemName'];
    type = json['type'];
    nested = json['nested'];
    vegType = json['vegType'];
    alert = json['alert'];
    duration = json['duration'];
    salesTax = json['salesTax'];
    itemDescription = json['itemDescription'];
    itemShortDescription = json['itemShortDescription'];
    itemPriority = json['itemPriority'];
    country = json['country'];
    isSubscription = json['isSubscription'];
    mode = json['mode'];
    tags = json['tags'];
    brand = json['brand'];
    nToken = json['_token'];
    userType = json['userType'];
    delivery = json['delivery'];
    isActive = json['isActive'];
    subscriptionModule = json['subscriptionModule'];
    subscription = json['subscription'];
    seller = json['seller'];
    b2bModule = json['b2bModule'];
    quantityData = json['quantity_data'];
    productType = json['productType'];
    singleSku = json['singleSku'];
    singleNetweight = json['singleNetweight'];
    singleBarcode = json['singleBarcode'];
    singleLoyalty = json['singleLoyalty'];
    singleMinItem = json['singleMinItem'];
    singleMaxItem = json['singleMaxItem'];
    singleUnit = json['singleUnit'];
    singleIncrementVal = json['singleIncrementVal'];
    fishprice = json['fishprice'];
    singleMrp = json['singleMrp'];
    singleSellingPrice = json['singleSellingPrice'];
    singleMembershipPrice = json['singleMembershipPrice'];
    singleHsn = json['singleHsn'];
    singleshortNote = json['singleshortNote'];
    topping = json['topping'];
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(new Variation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch'] = this.branch;
    data['user'] = this.user;
    data['branchtype'] = this.branchtype;
    data['replacementitems'] = this.replacementitems;
    data['itemName'] = this.itemName;
    data['type'] = this.type;
    data['nested'] = this.nested;
    data['vegType'] = this.vegType;
    data['alert'] = this.alert;
    data['duration'] = this.duration;
    data['salesTax'] = this.salesTax;
    data['itemDescription'] = this.itemDescription;
    data['itemShortDescription'] = this.itemShortDescription;
    data['itemPriority'] = this.itemPriority;
    data['country'] = this.country;
    data['isSubscription'] = this.isSubscription;
    data['mode'] = this.mode;
    data['tags'] = this.tags;
    data['brand'] = this.brand;
    data['_token'] = this.nToken;
    data['userType'] = this.userType;
    data['delivery'] = this.delivery;
    data['isActive'] = this.isActive;
    data['subscriptionModule'] = this.subscriptionModule;
    data['subscription'] = this.subscription;
    data['seller'] = this.seller;
    data['b2bModule'] = this.b2bModule;
    data['quantity_data'] = this.quantityData;
    data['productType'] = this.productType;
    data['singleSku'] = this.singleSku;
    data['singleNetweight'] = this.singleNetweight;
    data['singleBarcode'] = this.singleBarcode;
    data['singleLoyalty'] = this.singleLoyalty;
    data['singleMinItem'] = this.singleMinItem;
    data['singleMaxItem'] = this.singleMaxItem;
    data['singleUnit'] = this.singleUnit;
    data['singleIncrementVal'] = this.singleIncrementVal;
    data['fishprice'] = this.fishprice;
    data['singleMrp'] = this.singleMrp;
    data['singleSellingPrice'] = this.singleSellingPrice;
    data['singleMembershipPrice'] = this.singleMembershipPrice;
    data['singleHsn'] = this.singleHsn;
    data['singleshortNote'] = this.singleshortNote;
    data['topping'] = this.topping;
    if (this.variation != null) {
      data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variation {
  String? variationName;
  int? price;
  int? mrp;
  int? priority;
  int? min;
  int? max;
  int? membership;
  int? barcode;
  int? sku;
  int? hsn;
  int? weight;
  int? loyalty;
  Null? cost;
  Null? netWeight;
  String? unit;
  Null? status;
  int? cartexpiry;
  int? quantity;
  int? wholesale;
  int? priceperunit;
  Null? addon;
  Null? varnamesdata;
  Null? varlanguagedata;
  Null? unitsdata;
  Null? unitlanguagedata;
  Null? itemnames;
  Null? language;
  Null? desc;
  Null? languagedata;
  Null? manufacturedesc;
  Null? manifacturelanguagedata;
  String? category;
  int? brand;

  Variation(
      {this.variationName,
        this.price,
        this.mrp,
        this.priority,
        this.min,
        this.max,
        this.membership,
        this.barcode,
        this.sku,
        this.hsn,
        this.weight,
        this.loyalty,
        this.cost,
        this.netWeight,
        this.unit,
        this.status,
        this.cartexpiry,
        this.quantity,
        this.wholesale,
        this.priceperunit,
        this.addon,
        this.varnamesdata,
        this.varlanguagedata,
        this.unitsdata,
        this.unitlanguagedata,
        this.itemnames,
        this.language,
        this.desc,
        this.languagedata,
        this.manufacturedesc,
        this.manifacturelanguagedata,
        this.category,
        this.brand});

  Variation.fromJson(Map<String, dynamic> json) {
    variationName = json['variation_name'];
    price = json['price'];
    mrp = json['mrp'];
    priority = json['priority'];
    min = json['min'];
    max = json['max'];
    membership = json['membership'];
    barcode = json['barcode'];
    sku = json['sku'];
    hsn = json['hsn'];
    weight = json['weight'];
    loyalty = json['loyalty'];
    cost = json['cost'];
    netWeight = json['net_weight'];
    unit = json['unit'];
    status = json['status'];
    cartexpiry = json['cartexpiry'];
    quantity = json['quantity'];
    wholesale = json['wholesale'];
    priceperunit = json['priceperunit'];
    addon = json['addon'];
    varnamesdata = json['varnamesdata'];
    varlanguagedata = json['varlanguagedata'];
    unitsdata = json['unitsdata'];
    unitlanguagedata = json['unitlanguagedata'];
    itemnames = json['itemnames'];
    language = json['language'];
    desc = json['desc'];
    languagedata = json['languagedata'];
    manufacturedesc = json['manufacturedesc'];
    manifacturelanguagedata = json['manifacturelanguagedata'];
    category = json['category'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variation_name'] = this.variationName;
    data['price'] = this.price;
    data['mrp'] = this.mrp;
    data['priority'] = this.priority;
    data['min'] = this.min;
    data['max'] = this.max;
    data['membership'] = this.membership;
    data['barcode'] = this.barcode;
    data['sku'] = this.sku;
    data['hsn'] = this.hsn;
    data['weight'] = this.weight;
    data['loyalty'] = this.loyalty;
    data['cost'] = this.cost;
    data['net_weight'] = this.netWeight;
    data['unit'] = this.unit;
    data['status'] = this.status;
    data['cartexpiry'] = this.cartexpiry;
    data['quantity'] = this.quantity;
    data['wholesale'] = this.wholesale;
    data['priceperunit'] = this.priceperunit;
    data['addon'] = this.addon;
    data['varnamesdata'] = this.varnamesdata;
    data['varlanguagedata'] = this.varlanguagedata;
    data['unitsdata'] = this.unitsdata;
    data['unitlanguagedata'] = this.unitlanguagedata;
    data['itemnames'] = this.itemnames;
    data['language'] = this.language;
    data['desc'] = this.desc;
    data['languagedata'] = this.languagedata;
    data['manufacturedesc'] = this.manufacturedesc;
    data['manifacturelanguagedata'] = this.manifacturelanguagedata;
    data['category'] = this.category;
    data['brand'] = this.brand;
    return data;
  }
}






