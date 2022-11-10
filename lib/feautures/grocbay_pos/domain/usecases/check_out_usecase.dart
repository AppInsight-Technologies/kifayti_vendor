import 'package:dartz/dartz.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositorie/repository_provider.dart';

class CheckOutUsecase extends UseCase<OrderItem,CheckoutParms>{
  DependencyRepostProvider repo ;
  CheckOutUsecase(this.repo);
  @override
  Future<Either<Failure, OrderItem>> call({CheckoutParms? data}) async{
    print("Checkut parms:${data!.toJson()}");
    final value = await repo.getRequest(Params(uri: Uri.parse("v3/order/new-order-by-cart"),methed: Methed.PostJson,data: data.toJson(),));
    OrderItem vall = OrderItem();
    value.map((r) =>vall = Order.fromJson(r).order!);
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( vall)));
  }
}
class CheckoutParms {
  String? userId;
  String? walletType;
  String? walletBalance;
  String? apiKey;
  String? restId;
  String? addressId;
  String? orderType;
  String? paymentType;
  String? promocode;
  String? fixTime;
  String? fixdate;
  String? promo;
  String? only;
  String? channel;
  String? membership;
  String? membershipActive;
  String? note;
  String? branch;
  String? loyalty;
  String? loyaltyPoints;
  String? point;
  String? version;
  String? device;
  List<Items>? items;
  String? setsurveyMode ="0";
  String? posId;
  String? posPoint;

  CheckoutParms(
      {this.userId,
        this.walletType,
        this.walletBalance,
        this.apiKey,
        this.restId,
        this.addressId,
        this.orderType,
        this.paymentType,
        this.promocode,
        this.fixTime,
        this.fixdate,
        this.promo,
        this.only,
        this.channel,
        this.membership,
        this.membershipActive,
        this.note,
        this.branch,
        this.loyalty,
        this.loyaltyPoints,
        this.point,
        this.version,
        this.device,
        this.setsurveyMode = "0",
        this.items,
        this.posId,
        this.posPoint
      });

  CheckoutParms.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    walletType = json['walletType'];
    walletBalance = json['walletBalance'];
    apiKey = json['apiKey'];
    restId = json['restId'];
    addressId = json['addressId'];
    orderType = json['orderType'];
    paymentType = json['paymentType'];
    promocode = json['promocode'];
    fixTime = '9:00 AM - 9:00 PM';
    fixdate = json['fixdate'];
    promo = json['promo'];
    only = json['only'];
    channel = json['channel'];
    membership = json['membership'];
    membershipActive = json['membership_active'];
    note = json['note'];
    branch = json['branch'];
    loyalty = json['loyalty'];
    loyaltyPoints = json['loyalty_points'];
    point = json['point'];
    version = json['version'];
    setsurveyMode = json['survey_mode'];
    device = json['device'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    posId = json['posId'];
    posPoint = json['posPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['walletType'] = this.walletType;
    data['walletBalance'] = this.walletBalance;
    data['apiKey'] = this.apiKey;
    data['restId'] = this.restId;
    data['addressId'] = this.addressId;
    data['orderType'] = this.orderType;
    data['paymentType'] = this.paymentType;
    data['promocode'] = this.promocode;
    data['fix_time'] = this.fixTime;
    data['fixdate'] = this.fixdate;
    data['promo'] = this.promo;
    data['only'] = this.only;
    data['channel'] = this.channel;
    data['membership'] = this.membership;
    data['membership_active'] = this.membershipActive;
    data['note'] = this.note;
    data['branch'] = this.branch;
    data['survey_mode'] = this.setsurveyMode;
    data['loyalty'] = this.loyalty;
    data['loyalty_points'] = this.loyaltyPoints;
    data['point'] = this.point;
    data['version'] = this.version;
    data['device'] = this.device;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['posId'] = this.posId;
    data['posPoint'] = this.posPoint;
    return data;
  }
}

class Items {
  String? productId;
  String? priceVariation;
  String? quantity;
  String? mrp;
  String? price;
  String? weight;
  String? type;

  Items(
      {this.productId,
        this.priceVariation,
        this.quantity,
        this.mrp,
        this.price,
        this.weight,
        this.type,
      });

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    priceVariation = json['priceVariation'];
    quantity = json['quantity'];
    mrp = json['mrp'];
    price = json['price'];
    type = json['type'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productId'] = this.productId;
    data['priceVariation'] = this.priceVariation;
    data['quantity'] = this.quantity;
    data['mrp'] = this.mrp;
    data['price'] = this.price;
    data['type'] = this.type;
    data['weight']= this.weight;
    return data;
  }
}

class Order {
  bool? status;
  OrderItem? order;

  Order({this.status, this.order});

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    order = json['order'] != null ? OrderItem.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class OrderItem {
  String? id;
  String? orderDate;
  String? actualAmount;
  String? tray;
  String? adminNote;
  String? tips;
  String? picker;
  String? branch;
  String? referenceID;
  String? ref;
  String? isMerged;
  String? area;
  String? cost;
  String? membership;
  String? version;
  String? addressId;
  String? totalTax;
  String? deliveryCharge;
  String? channel;
  String? totalDiscount;
  String? orderAmount;
  String? customerName;
  String? address;
  String? landmark;
  String? logitude;
  String? latitude;
  String? orderType;
  String? paymentType;
  String? paymentStatus;
  String? orderStatus;
  String? loyalty;
  String? wallet;
  String? sortTime;
  String? restoAppFee;
  String? restPay;
  String? fixtime;
  String? fixdate;
  String? areaid;
  String? invoice;
  String? seller;
  String? subscriptionId;
  // List<Null>? customerOrderItems;

  OrderItem(
      {this.id,
        this.orderDate,
        this.actualAmount,
        this.tray,
        this.adminNote,
        this.tips,
        this.picker,
        this.branch,
        this.referenceID,
        this.ref,
        this.isMerged,
        this.area,
        this.cost,
        this.membership,
        this.version,
        this.addressId,
        this.totalTax,
        this.deliveryCharge,
        this.channel,
        this.totalDiscount,
        this.orderAmount,
        this.customerName,
        this.address,
        this.landmark,
        this.logitude,
        this.latitude,
        this.orderType,
        this.paymentType,
        this.paymentStatus,
        this.orderStatus,
        this.loyalty,
        this.wallet,
        this.sortTime,
        this.restoAppFee,
        this.restPay,
        this.fixtime,
        this.fixdate,
        this.areaid,
        this.invoice,
        this.seller,
        this.subscriptionId,
        /*this.customerOrderItems*/});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDate = json['orderDate'];
    actualAmount = json['actualAmount'];
    tray = json['tray'];
    adminNote = json['adminNote'];
    tips = json['tips'];
    picker = json['picker'];
    branch = json['branch'];
    referenceID = json['referenceID'];
    ref = json['ref'];
    isMerged = json['isMerged'];
    area = json['area'];
    cost = json['cost'];
    membership = json['membership'];
    version = json['version'];
    addressId = json['addressId'];
    totalTax = json['totalTax'];
    deliveryCharge = json['deliveryCharge'];
    channel = json['channel'];
    totalDiscount = json['totalDiscount'];
    orderAmount = json['orderAmount'];
    customerName = json['customerName'];
    address = json['address'];
    landmark = json['landmark'];
    logitude = json['logitude'];
    latitude = json['latitude'];
    orderType = json['orderType'];
    paymentType = json['paymentType'];
    paymentStatus = json['paymentStatus'];
    orderStatus = json['orderStatus'];
    loyalty = json['loyalty'];
    wallet = json['wallet'];
    sortTime = json['sortTime'];
    restoAppFee = json['restoAppFee'];
    restPay = json['restPay'];
    fixtime = json['fixtime'];
    fixdate = json['fixdate'];
    areaid = json['areaid'];
    invoice = json['invoice'];
    seller = json['seller'];
    subscriptionId = json['subscriptionId'];
    /* if (json['customerOrderItems'] != null) {
      customerOrderItems = <Null>[];
      json['customerOrderItems'].forEach((v) {
        customerOrderItems!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['orderDate'] = this.orderDate;
    data['actualAmount'] = this.actualAmount;
    data['tray'] = this.tray;
    data['adminNote'] = this.adminNote;
    data['tips'] = this.tips;
    data['picker'] = this.picker;
    data['branch'] = this.branch;
    data['referenceID'] = this.referenceID;
    data['ref'] = this.ref;
    data['isMerged'] = this.isMerged;
    data['area'] = this.area;
    data['cost'] = this.cost;
    data['membership'] = this.membership;
    data['version'] = this.version;
    data['addressId'] = this.addressId;
    data['totalTax'] = this.totalTax;
    data['deliveryCharge'] = this.deliveryCharge;
    data['channel'] = this.channel;
    data['totalDiscount'] = this.totalDiscount;
    data['orderAmount'] = this.orderAmount;
    data['customerName'] = this.customerName;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['logitude'] = this.logitude;
    data['latitude'] = this.latitude;
    data['orderType'] = this.orderType;
    data['paymentType'] = this.paymentType;
    data['paymentStatus'] = this.paymentStatus;
    data['orderStatus'] = this.orderStatus;
    data['loyalty'] = this.loyalty;
    data['wallet'] = this.wallet;
    data['sortTime'] = this.sortTime;
    data['restoAppFee'] = this.restoAppFee;
    data['restPay'] = this.restPay;
    data['fixtime'] = this.fixtime;
    data['fixdate'] = this.fixdate;
    data['areaid'] = this.areaid;
    data['invoice'] = this.invoice;
    data['seller'] = this.seller;
    data['subscriptionId'] = this.subscriptionId;
    /* if (this.customerOrderItems != null) {
      data['customerOrderItems'] =
          this.customerOrderItems!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

