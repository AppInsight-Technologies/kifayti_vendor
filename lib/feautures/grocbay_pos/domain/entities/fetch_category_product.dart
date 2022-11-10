

import '../../../../core/util/presentation/constants/ic_constants.dart';

class PriceVariation {
  int? loyalty;
  String? netWeight;
  String? id;
  String? menuItemId;
  String? variationName;
  double? price;
  String? priority;
  double? mrp;
  int? stock;
  String? maxItem;
  String? unit;
  String? status;
  String? minItem;
  double? membershipPrice;
  int? loyaltys;
  List<Images>? images;
  String? weight;
  int? quantity;

  PriceVariation(
      {this.loyalty,
        this.netWeight,
        this.id,
        this.menuItemId,
        this.variationName,
        this.price,
        this.priority,
        this.mrp,
        this.stock,
        this.maxItem,
        this.unit,
        this.status,
        this.minItem,
        this.membershipPrice,
        this.loyaltys,
        this.images,
        this.weight,
        this.quantity});

  PriceVariation.fromJson(Map<String, dynamic> json) {
    loyalty = json['loyalty'];
    netWeight = json['net_weight'];
    id = json['id'];
    menuItemId = json['menu_item_id'];
    variationName = json['variation_name'];
    price = (json['price'] as num).toDouble();
    priority = json['priority'];
    mrp = (json['mrp'] as num).toDouble();
    stock = json['stock'];
    maxItem = json['max_item'].toString();
    unit = json['unit'];
    status = json['status'];
    minItem = json['min_item'];
    membershipPrice = double.parse(json['membership_price'].toString());
    loyaltys = json['loyaltys'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    weight = json['weight'].toString();
    quantity = int.parse((json['quantity']??"1").toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loyalty'] = this.loyalty;
    data['net_weight'] = this.netWeight;
    data['id'] = this.id;
    data['menu_item_id'] = this.menuItemId;
    data['variation_name'] = this.variationName;
    data['price'] = this.price;
    data['priority'] = this.priority;
    data['mrp'] = this.mrp;
    data['stock'] = this.stock;
    data['max_item'] = this.maxItem;
    data['unit'] = this.unit;
    data['status'] = this.status;
    data['min_item'] = this.minItem;
    data['membership_price'] = this.membershipPrice;
    data['loyaltys'] = this.loyaltys;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    data['quantity'] = this.quantity;
    return data;
  }
}
class FetchCategoryProduct {
  List<Addon>? addon;
  String? id;
  String? eligibleForExpress;
  Object? deliveryDuration;
  String? eligibleForSubscription;
  List<SubscriptionSlot>? subscriptionSlot;
  String? paymentMode;
  String? duration;
  String? categoryId;
  String? itemName;
  String? itemSlug;
  String? vegType;
  String? itemFeaturedImage;
  String? regularPrice;
  String? salePrice;
  bool? isActive;
  String? salesTax;
  String? totalQty;
  String? itemDescription;
  String? brand;
  String? type;
  List<PriceVariation>? priceVariation;
  int? loyalty;
  String? netWeight;
  double? price;
  String? priority;
  double? mrp;
  int? stock;
  int? maxItem;
  int? minItem;
  String? weight;
  double? membershipPrice;
  String? unit;
  int? loyaltys;
  String? quantity;
  String? increament;
  String? status;
  String? singleshortNote;

  FetchCategoryProduct({this.addon, this.id, this.eligibleForExpress, this.deliveryDuration, this.eligibleForSubscription, this.subscriptionSlot, this.paymentMode, this.duration, this.categoryId, this.itemName, this.itemSlug, this.vegType, this.itemFeaturedImage, this.regularPrice, this.salePrice, this.isActive, this.salesTax, this.totalQty, this.itemDescription, this.brand, this.type, this.priceVariation, this.loyalty, this.netWeight, this.price, this.priority, this.mrp, this.stock, this.maxItem, this.minItem, this.weight, this.membershipPrice, this.unit, this.loyaltys, this.quantity, this.increament, this.status, this.singleshortNote});

  FetchCategoryProduct.fromJson(Map<String, dynamic> json) {
    if (json['addon'] != null) {
      addon = [];
      json['addon'].forEach((v) { addon?.add(new Addon.fromJson(v)); });
    }
    id = json['id'];
    eligibleForExpress = json['eligible_for_express'];
    if(json['delivery_duration'] is String) {
      deliveryDuration = json['delivery_duration'] as String;
    }else{
      deliveryDuration = json['delivery_duration'] as DeleveryDuration ;
    }
    eligibleForSubscription = json['eligible_for_subscription'];
    if (json['subscription_slot'] != null) {
      subscriptionSlot = <SubscriptionSlot>[];
      json['subscription_slot'].forEach((v) { subscriptionSlot!.add(new SubscriptionSlot.fromJson(v)); });
    }
    paymentMode = json['payment_mode'];
    duration = json['duration'];
    categoryId = json['category_id'];
    itemName = json['item_name'];
    itemSlug = json['item_slug'];
    vegType = json['veg_type'];
    itemFeaturedImage = json['item_featured_image']!=null?"${IConstants.API_IMAGE}items/images/"+json['item_featured_image']:"";
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    isActive = json['is_active'].toString()=="1";
    salesTax = json['sales_tax'];
    totalQty = json['total_qty'];
    itemDescription = json['item_description'];
    brand = json['brand'];
    type = json['type'];
    if (json['price_variation'] != null&&type == "0") {
      priceVariation = <PriceVariation>[];
      json['price_variation'].forEach((v) { priceVariation!.add(new PriceVariation.fromJson(v)); });
    }
    loyalty = json['loyalty'];
    netWeight = json['net_weight'];
    price = double.parse(json['price'].toString());
    priority = json['priority'];
    mrp = json['mrp']!=null?(json['mrp'] as num ).toDouble():null;
    stock = json['stock'];
    maxItem = json['max_item']!=null?int.parse(json['max_item'].toString()):null;
    minItem = json['min_item']!=null?int.parse(json['min_item'].toString()):null;
    weight = json['weight'];
    membershipPrice = double.parse(json['membership_price'].toString());
    unit = json['unit'];
    loyaltys = json['loyaltys'];
    quantity = json['quantity'];
    increament = json['increament']??"1";
    status = json['status'];
    singleshortNote = json['singleshortNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addon != null) {
      data['addon'] = this.addon!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['eligible_for_express'] = this.eligibleForExpress;
    data['delivery_duration'] = this.deliveryDuration;
    data['eligible_for_subscription'] = this.eligibleForSubscription;
    if (this.subscriptionSlot != null) {
      data['subscription_slot'] = this.subscriptionSlot!.map((v) => v.toJson()).toList();
    }
    data['payment_mode'] = this.paymentMode;
    data['duration'] = this.duration;
    data['category_id'] = this.categoryId;
    data['item_name'] = this.itemName;
    data['item_slug'] = this.itemSlug;
    data['veg_type'] = this.vegType;
    data['item_featured_image'] = this.itemFeaturedImage;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['is_active'] = this.isActive;
    data['sales_tax'] = this.salesTax;
    data['total_qty'] = this.totalQty;
    data['item_description'] = this.itemDescription;
    data['brand'] = this.brand;
    data['type'] = this.type;
    if (this.priceVariation != null) {
      data['price_variation'] = this.priceVariation!.map((v) => v.toJson()).toList();
    }
    data['loyalty'] = this.loyalty;
    data['net_weight'] = this.netWeight;
    data['price'] = this.price;
    data['priority'] = this.priority;
    data['mrp'] = this.mrp;
    data['stock'] = this.stock;
    data['max_item'] = this.maxItem;
    data['min_item'] = this.minItem;
    data['weight'] = this.weight;
    data['membership_price'] = this.membershipPrice;
    data['unit'] = this.unit;
    data['loyaltys'] = this.loyaltys;
    data['quantity'] = this.quantity;
    data['increament'] = this.increament;
    data['status'] = this.status;
    data['singleshortNote'] = this.singleshortNote;
    return data;
  }
}

class Addon {
  String? status;
  String? type;
  String? id;
  String? name;
  String? branch;
  String? date;
  List<AddonList>? list;

  Addon({this.status, this.type, this.id, this.name, this.branch, this.date, this.list});

  Addon.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    id = json['id'];
    name = json['name'];
    branch = json['branch'];
    date = json['date'];
    if (json['list'] != null) {

      json['list'].forEach((v) { list?.add(new AddonList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['branch'] = this.branch;
    data['date'] = this.date;
    if (this.list != null) {
      data['list'] = this.list?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddonList {
  String? id;
  String? ref;
  String? name;
  String? price;
  String? status;

  AddonList({this.id, this.ref, this.name, this.price, this.status});

  AddonList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ref = json['ref'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref'] = this.ref;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    return data;
  }
}

class SubscriptionSlot {
  String? id;
  String? name;
  String? cronTime;
  String? deliveryTime;
  String? branch;
  String? status;

  SubscriptionSlot({this.id, this.name, this.cronTime, this.deliveryTime, this.branch, this.status});

  SubscriptionSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cronTime = json['cronTime'];
    deliveryTime = json['deliveryTime'];
    branch = json['branch'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cronTime'] = cronTime;
    data['deliveryTime'] = deliveryTime;
    data['branch'] = this.branch;
    data['status'] = this.status;
    return data;
  }
}

class Images {
  String? id;
  String? image;
  String? ref;

  Images({this.id, this.image, this.ref});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image']!=null?"${IConstants.API_IMAGE}items/images/"+json['image']:"";
    ref = json['ref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['ref'] = this.ref;
    return data;
  }
}
class DeleveryDuration {
  String? id;
  String? name;
  String? durationType;
  String? duration;
  String? status;
  String? branch;
  String? note;
  String? blockFor;

  DeleveryDuration(
      {this.id,
        this.name,
        this.durationType,
        this.duration,
        this.status,
        this.branch,
        this.note,
        this.blockFor});

  DeleveryDuration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    durationType = json['durationType'];
    duration = json['duration'];
    status = json['status'];
    branch = json['branch'];
    note = json['note'];
    blockFor = json['blockFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['durationType'] = durationType;
    data['duration'] = duration;
    data['status'] = status;
    data['branch'] = branch;
    data['note'] = note;
    data['blockFor'] = blockFor;
    return data;
  }
}