import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/get_coupans.dart';
import '../repositorie/repository_provider.dart';

class GetCoupansUsecase extends UseCase<getCoupans,GetPromoParams>{
  DependencyRepostProvider repo ;
  GetCoupansUsecase({required this.repo});

  @override
  Future<Either<Failure, getCoupans>> call({GetPromoParams? data}) async{
    // TODO: implement call

    final value = await repo.getRequest(Params(uri: Uri.parse("get-coupans"),methed: Methed.Post,data: {"user":data!.user, "branch":sl<SharedPreferences>().getString(Prefrence.BRANCH), "items":data.items, "price":data.price,}));
    // final value = await repo.getRequest(Params(uri: Uri.parse("get-coupans"),methed: Methed.Post,data: {"user":496, "branch":999, "items":[
    //   {"itemid":66,"qty":1,"price":17}
    //       ], "price":200,}));
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( getCoupans.fromJson(r))));
  }

}
class GetPromoParams{
  late String items;
  late String user;
  late String price;
  GetPromoParams({required this.items, required this.user, required this.price});
}