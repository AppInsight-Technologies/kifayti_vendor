class UpdateOrderModel {
  String? promocodeDiscount;
  String? loyaltyEarned;
  int? membershipEarned;
  String? tips;
  int? wallet;
  int? loyalty;
  String? id;
  String? invoice;
  String? orderDate;
  String? actualAmount;
  String? totalTax;
  String? totalDiscount;
  String? orderAmount;
  String? customerName;
  String? address;
  String? promocode;
  String? orderType;
  String? paymentType;
  String? paymentStatus;
  String? restPay;
  String? fixtime;
  String? fixdate;
  String? orderStatus;
  String? deliveryCharge;
  int? itemsCount;
  List<Items>? items;
  int? refund;
  String? restaurantName;

  UpdateOrderModel(
      {this.promocodeDiscount,
        this.loyaltyEarned,
        this.membershipEarned,
        this.tips,
        this.wallet,
        this.loyalty,
        this.id,
        this.invoice,
        this.orderDate,
        this.actualAmount,
        this.totalTax,
        this.totalDiscount,
        this.orderAmount,
        this.customerName,
        this.address,
        this.promocode,
        this.orderType,
        this.paymentType,
        this.paymentStatus,
        this.restPay,
        this.fixtime,
        this.fixdate,
        this.orderStatus,
        this.deliveryCharge,
        this.itemsCount,
        this.items,
        this.refund,
        this.restaurantName});

  UpdateOrderModel.fromJson(Map<String, dynamic> json) {
    promocodeDiscount = json['promocode_discount'];
    loyaltyEarned = json['loyalty_earned'];
    membershipEarned = json['membership_earned'];
    tips = json['tips'];
    wallet = json['wallet'];
    loyalty = json['loyalty'];
    id = json['id'];
    invoice = json['invoice'];
    orderDate = json['orderDate'];
    actualAmount = json['actualAmount'];
    totalTax = json['totalTax'];
    totalDiscount = json['totalDiscount'];
    orderAmount = json['orderAmount'];
    customerName = json['customerName'];
    address = json['address'];
    promocode = json['promocode'];
    orderType = json['orderType'];
    paymentType = json['paymentType'];
    paymentStatus = json['paymentStatus'];
    restPay = json['restPay'];
    fixtime = json['fixtime'];
    fixdate = json['fixdate'];
    orderStatus = json['orderStatus'];
    deliveryCharge = json['deliveryCharge'];
    itemsCount = json['itemsCount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    refund = json['refund'];
    restaurantName = json['restaurantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promocode_discount'] = this.promocodeDiscount;
    data['loyalty_earned'] = this.loyaltyEarned;
    data['membership_earned'] = this.membershipEarned;
    data['tips'] = this.tips;
    data['wallet'] = this.wallet;
    data['loyalty'] = this.loyalty;
    data['id'] = this.id;
    data['invoice'] = this.invoice;
    data['orderDate'] = this.orderDate;
    data['actualAmount'] = this.actualAmount;
    data['totalTax'] = this.totalTax;
    data['totalDiscount'] = this.totalDiscount;
    data['orderAmount'] = this.orderAmount;
    data['customerName'] = this.customerName;
    data['address'] = this.address;
    data['promocode'] = this.promocode;
    data['orderType'] = this.orderType;
    data['paymentType'] = this.paymentType;
    data['paymentStatus'] = this.paymentStatus;
    data['restPay'] = this.restPay;
    data['fixtime'] = this.fixtime;
    data['fixdate'] = this.fixdate;
    data['orderStatus'] = this.orderStatus;
    data['deliveryCharge'] = this.deliveryCharge;
    data['itemsCount'] = this.itemsCount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['refund'] = this.refund;
    data['restaurantName'] = this.restaurantName;
    return data;
  }
}

class Items {
  String? edited;
  String? vegType;
  String? tax;
  String? id;
  String? orderD;
  String? itemId;
  String? itemName;
  String? priceVariavtion;
  String? price;
  double? mrp;
  String? quantity;
  String? uquantity;
  String? weight;
  String? uweight;
  String? actualAmount;
  String? extraAmount;
  String? discount;
  String? subTotal;
  String? isTray;
  String? loyalty;
  String? image;
  String? menuid;
  String? barcode;
  String? returnTime;
  String? replacement;
  String? replacementQty;
  String? itemType;
  List<ReplacementItem>? replacementItem;
  String? toppings;
  List<ToppingsData>? toppingsData;
  bool? colorCheck ;
  String? prepare;
  bool? varedit;
 bool? checkboxval;
 String? selectedreason;
  int? indexvalue;

  Items(
      {this.edited,
        this.vegType,
        this.tax,
        this.id,
        this.orderD,
        this.itemId,
        this.itemName,
        this.priceVariavtion,
        this.price,
        this.mrp,
        this.quantity,
        this.uquantity,
        this.weight,
        this.uweight,
        this.actualAmount,
        this.extraAmount,
        this.discount,
        this.subTotal,
        this.isTray,
        this.loyalty,
        this.image,
        this.menuid,
        this.barcode,
        this.returnTime,
        this.replacement,
        this.replacementQty,
        this.itemType,
        this.replacementItem,
        this.toppings,
        this.toppingsData,
        this.colorCheck,
        this.prepare,
        this.checkboxval,
        this.varedit,
        this.selectedreason,
        this.indexvalue,
      });

  Items.fromJson(Map<String, dynamic> json) {
    edited = json['edited'];
    vegType = json['veg_type'];
    tax = json['tax'];
    id = json['id'];
    orderD = json['order_d'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    priceVariavtion = json['priceVariavtion'];
    price = json['price'];
    mrp = double.parse(json['mrp'].toString());
    quantity = json['quantity'];
    uquantity = json['quantity'];
    weight = json['weight'];
    uweight = json['weight'];
    actualAmount = json['actualAmount'];
    extraAmount = json['extraAmount'];
    discount = json['discount'];
    subTotal = json['subTotal'];
    isTray = json['isTray'];
    loyalty = json['loyalty'];
    image = (json['image']==null||json['image']==[])?"" :json['image'];
    menuid = json['menuid'];
    barcode = json['barcode'];
    returnTime = json['return_time'];
    replacement = json['replacement'];
    replacementQty = json['replacement_qty'];
    itemType = json['item_type'];
    if (json['replacement_item'] != null) {
      replacementItem = <ReplacementItem>[];
      json['replacement_item'].forEach((v) {
        replacementItem!.add( ReplacementItem.fromJson(v));
      });
    }
    toppings = json['toppings'];
    if (json['toppings_data'] != null) {
      toppingsData = <ToppingsData>[];
      json['toppings_data'].forEach((v) {
        toppingsData!.add(ToppingsData.fromJson(v));
      });
    }
    colorCheck = false;
    prepare = "PRPARING";
    checkboxval= false;
    varedit = false;
    selectedreason = 'No Issues';
    indexvalue = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['edited'] = this.edited;
    data['veg_type'] = this.vegType;
    data['tax'] = this.tax;
    data['id'] = this.id;
    data['order_d'] = this.orderD;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['priceVariavtion'] = this.priceVariavtion;
    data['price'] = this.price;
    data['mrp'] = this.mrp;
    data['quantity'] = this.quantity;
    data['uquantity'] = this.uquantity;
    data['weight'] = this.weight;
    data['uweight'] = this.uweight;
    data['actualAmount'] = this.actualAmount;
    data['extraAmount'] = this.extraAmount;
    data['discount'] = this.discount;
    data['subTotal'] = this.subTotal;
    data['isTray'] = this.isTray;
    data['loyalty'] = this.loyalty;
    data['image'] = this.image;
    data['menuid'] = this.menuid;
    data['barcode'] = this.barcode;
    data['return_time'] = this.returnTime;
    data['replacement'] = this.replacement;
    data['replacement_qty'] = this.replacementQty;
    data['item_type'] = this.itemType;
    if (this.replacementItem != null) {
      data['replacement_item'] =
          this.replacementItem!.map((v) => v.toJson()).toList();
    }
    data['toppings'] = this.toppings;
    if (this.toppingsData != null) {
      data['toppings_data'] =
          this.toppingsData!.map((v) => v.toJson()).toList();
    }
    data['colorCheck'] = this.colorCheck;
    data['prepare'] = this.prepare;
    data['checkboxval']= this.checkboxval;
    data['varedit'] = this.varedit;
    data['selectedreason'] = this.selectedreason;
    data['indexvalue'] = this.indexvalue;
    return data;
  }
}

class ReplacementItem  {
  String? tedited;
  String? ttax;
  String? tid;
  String? torderD;
  String? titemId;
  String? titemName;
  String? tpriceVariavtion;
  String? tprice;
  ReplacementItem({
    this.tedited,
    this.ttax,
    this.tid,
    this.torderD,
    this.titemId,
    this.titemName,
    this.tpriceVariavtion,
    this.tprice,
  });
  ReplacementItem.fromJson(Map<String, dynamic> json) {
    titemName = json['itemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.titemName;
    return data;
  }


}

class ToppingsData {
   String? tedited;
   String? ttax;
   String? tid;
   String? torderD;
   String? titemId;
   String? titemName;
   String? tpriceVariavtion;
   String? tprice;
   int? tmrp;
   String? tquantity;
   String? tweight;
   String? tactualAmount;
   String? textraAmount;
   String? tdiscount;
   String? tsubTotal;
   String? tisTray;
   String? ttrayQty;
   String? tloyalty;
   String? tbarcode;
   String? treturnTime;
   String? titemType;
   String? ttoppings;
   String? tparent_id;
   String? resturantname;

  ToppingsData({
    this.tedited,
    this.ttax,
    this.tid,
    this.torderD,
    this.titemId,
    this.titemName,
    this.tpriceVariavtion,
    this.tprice,
    this.tmrp,
    this.tquantity,
    this.tweight,
    this.tactualAmount,
    this.textraAmount,
    this.tdiscount,
    this.tsubTotal,
    this.tisTray,
    this.ttrayQty,
    this.tloyalty,
    this.tbarcode,
    this.treturnTime,
    this.titemType,
    this.ttoppings,
    this.tparent_id,
    this.resturantname
});

  ToppingsData.fromJson(Map<String, dynamic> json) {
    titemName = json['itemName'];
    tquantity = json['quantity'];
    tprice = json['price'];
    tweight = json['weight'];
    titemId = json['itemId'];
    tparent_id = json['parent_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.titemName;
    data['type'] = this.tquantity;
    data['id'] = this.tprice;
    data['name'] = this.tweight;
    data['branch'] = this.titemId;
    data['date'] = this.tparent_id;

    return data;
  }
}