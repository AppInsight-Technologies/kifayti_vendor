import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositorie/repository_provider.dart';

class editOrderStatusUsecase extends UseCase<bool,editOrderStatusParams>{
  DependencyRepostProvider repo ;
  editOrderStatusUsecase(this.repo);

  @override
  Future<Either<Failure, bool>> call({editOrderStatusParams? data}) async{
    // TODO: implement call
    final value = await repo.getRequest(Params(uri: Uri.parse("v2/edit-order-picker-new"),methed: Methed.Post,data:{"order": data?.order??'', "items":data?.items?.map((e) =>  '{"id": ${e.id}, "qty":${e.qty}, "oqty": ${e.oqty}, "loyalty": ${e.loyalty}, "reason":"${e.reason}", "price": ${e.price}, "weight": ${e.weight}, "cweight": ${e.cweight}, "type": ${e.type}}').toList(), "deliveryBoy": "", "isDelivery": 0,"minus":"1"}));
     print("value.....hii..."+value.toString());
    // value.map((r) => true);
    return  Future.value(value.fold((l) {

      return Left(l);
    }, (r) {
      print("right...");
      return Right(true);
    }));
  }

}
class editOrderStatusParams{
  late String order;
  List<ItemsList>? items;
  String? deliveryBoy;
  String? isDelivery;
  String? minus;
  editOrderStatusParams({required this.order,this.items,this.deliveryBoy,this.isDelivery,this.minus});

  editOrderStatusParams.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    if (json['items'] != null) {
      items = <ItemsList>[];
      json['items'].forEach((v) {
        items!.add(ItemsList.fromJson(v));
      });
    }
    deliveryBoy = json['deliveryBoy'];
    isDelivery = json['isDelivery'];
    minus = json['minus'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['order'] = this.order;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['deliveryBoy'] = this.deliveryBoy;
    data['isDelivery'] = this.isDelivery;
    data['minus'] = this.minus;
    return data;
  }
}

class ItemsList {
  String? id;
  String? qty;
  String? oqty;
  String? loyalty;
  String? reason;
  String? price;
  String? weight;
  String? cweight;
  String? type;

  ItemsList(
      {this.id,
        this.qty,
        this.oqty,
        this.loyalty,
        this.reason,
        this.price,
        this.weight,
        this.cweight,
        this.type
      });

  ItemsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    oqty = json['oqty'];
    loyalty = json['loyalty'];
    reason = json['reason'];
    price = json['price'];
    weight = json['weight'];
    cweight = json['cweight'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['oqty'] = this.oqty;
    data['loyalty'] = this.loyalty;
    data['reason'] = this.reason;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['cweight'] = this.cweight;
    data['type'] = this.type;
     return data;
  }
}