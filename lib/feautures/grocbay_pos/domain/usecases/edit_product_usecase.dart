import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositorie/repository_provider.dart';

class editProductUsecase extends UseCase<bool,editProductEventParams>{
  DependencyRepostProvider repo ;
  editProductUsecase(this.repo);

  @override
  Future<Either<Failure, bool>> call({editProductEventParams? data}) async{
    // TODO: implement call
    final value = await repo.getRequest(Params(uri: Uri.parse("pos-edit-item"),methed: Methed.Post,data:{
      "branchtype":data!.branchtype,
      "branch":data.branch,
      "userType":data.userType,
      "user":data.user,
      "menu_id":data.menu_id,
      "singlestock":data.singlestock,
      "singleprice":data.singleprice,
      "singlemrp":data.singlemrp,
      "singlemembership_price":data.singlemembership_price,
      "type":data.type,
      "var_id":data.var_id
     /* "items":data.items?.map((e) =>  '{"var_id": ${e.var_id}, '
          '"stock":${e.stock}, "mrp": ${e.mrp}, "price": ${e.price}, "membership_price":"${e.membership_price}}').toList(),*/
     }));

    // value.map((r) => true);
    return  Future.value(value.fold((l) {

      return Left(l);
    }, (r) {
      print("right...");
      return Right(true);
    }));
  }

}
class editProductEventParams{
   String? branchtype;
  String? branch;
  String? userType;
  String? user;
   String? menu_id;
   String? singlestock;
   String? singleprice;
   String? singlemrp;
   String? singlemembership_price;
   String? type;
   String? var_id;
 //  List<ItemsProduct>? items;
  editProductEventParams({ this.branchtype,this.branch,this.userType,this.user,this.menu_id,
    this.singlestock,this.singleprice,this.singlemrp,this.singlemembership_price,this.type,this.var_id});

  editProductEventParams.fromJson(Map<String, dynamic> json) {
  /*  if (json['items'] != null) {
      items = <ItemsProduct>[];
      json['items'].forEach((v) {
        items!.add(ItemsProduct.fromJson(v));
      });
    }*/
    branchtype = json['branchtype'];
    branch = json['branch'];
    userType = json['userType'];
    type = json['type'];
    user = json['user'];
    menu_id = json['menu_id'];
    singlestock = json['singlestock'];
    singleprice = json['singleprice'];
    singlemrp = json['singlemrp'];
    singlemembership_price = json['singlemembership_price'];
    var_id = json['var_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
  /*  if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }*/
    data['branchtype'] = this.branchtype;
    data['branch'] = this.branch;
    data['userType'] = this.userType;
    data['type'] = this.type;
    data['user'] = this.user;
    data['menu_id'] = this.menu_id;
    data['singlestock'] = this.singlestock;
    data['singleprice'] = this.singleprice;
    data['singlemrp'] = this.singlemrp;
    data['singlemembership_price'] = this.singlemembership_price;
    data['var_id'] = this.var_id;
    return data;
  }
}

class ItemsProduct {
  String? var_id;
  String? stock;
  String? price;
  String? mrp;
  String? membership_price;


  ItemsProduct(
      {this.var_id,
        this.stock,
        this.price,
        this.mrp,
        this.membership_price,

      });

  ItemsProduct.fromJson(Map<String, dynamic> json) {
    var_id = json['var_id'];
    stock = json['stock'];
    price = json['price'];
    mrp = json['mrp'];
    membership_price = json['membership_price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['var_id'] = this.var_id;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['mrp'] = this.mrp;
    data['membership_price'] = this.membership_price;
    return data;
  }
}