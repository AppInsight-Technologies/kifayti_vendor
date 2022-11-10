import 'package:dartz/dartz.dart';


import '../../../../core/data/hive_db.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_item_modle.dart';
import '../repositorie/repository_provider.dart';

class CartItemUseCase extends UseCase<List<CartItemModel>,CartParms>{
  DependencyRepostProvider<Map<String,dynamic>> repo ;
  CartItemUseCase(this.repo);
  @override
  Future<Either<Failure, List<CartItemModel>>> call({CartParms? data}) async {
    // TODO: implement call
    List<CartItemModel> list= [];
    final value =  await repo.getLocalDBRequest(LDBParams(table: DBTable.CartData,key: "cart",methed: data!.method,data: data.data));
    try {
      value.fold((l) => Left(l), (r) => r["data"].forEach((v){
        list.add(CartItemModel.fromJson(v));
      }));
    }  catch (e) {
      if(data.data!=null) {
        print("error but null ${data.data}");
        list.add(CartItemModel.fromJson(data.data!));
      } else{
        print("data is emplty");
      }
    }
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }
  Future<Either<Failure, List<CartItemModel>>> holdCart({CartParms? data}) async{
    List<CartItemModel> list= [];
    final value =  await repo.getLocalDBRequest(LDBParams(table: DBTable.CartData,key: "cart_hold",methed: data!.method,data: data.data));
    try {
      value.fold((l) => Left(l), (r) => r["data"].forEach((v){
        list.add(CartItemModel.fromJson(v));
      }));
    }  catch (e) {
      if(data.data!=null) {
        print("error but not null ${data.data}");
        list.add(CartItemModel.fromJson(data.data!));
      } else{
        print("data is emplty");
      }
    }
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }
}
class CartParms {
  DB method;
  Map<String,dynamic>? data;
  CartParms(this.method, [this.data]);
}