import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/data/hive_db.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../injection_container.dart';
import '../entities/get_shop.dart';
import '../repositorie/repository_provider.dart';

class GetShopUseCase extends UseCase<GetShop,Param>{
  DependencyRepostProvider repo;
  GetShopUseCase({required this.repo});
  @override
  Future<Either<Failure, GetShop>> call({Param? data}) async{
    // TODO: implement call
    List<GetShop> list=[];
    print({"branch":data!.data["branch"] }.toString());
    final value = await repo.getRequest(Params(uri: Uri.parse("get-resturant"),methed: Methed.Get,data: {"branch":data.data["branch"] }));
    value.map((r) => list.add(GetShop.fromJson(r)));
    repo.getLocalDBRequest(LDBParams(methed: DB.SET,key: "shop",table: DBTable.UserProfile,data:list.first.toJson() ));
    value.map((r) => list.add(GetShop.fromJson(r)));
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list.first)));
  }
}