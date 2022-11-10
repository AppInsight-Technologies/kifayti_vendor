import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/hive_db.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/getRestaraunt.dart';
import '../entities/get_profile_modle.dart';
import '../repositorie/repository_provider.dart';

class GetProfileCustomerUcase extends UseCase<GetCustomerProfile,CustomerProfileParam> {
  DependencyRepostProvider repo;

  GetProfileCustomerUcase({required this.repo});
  @override
  Future<Either<Failure, GetCustomerProfile>> call({CustomerProfileParam? data}) async{
    // TODO: implement call
    Map<String,dynamic> mapdata ={};
    if(data!.method==DB.GET){
      final val = await repo.getRequest(Params(uri: Uri.parse("customer/get-profile"),methed: Methed.Post,data: {"apiKey":data.u_id,'branch':sl<SharedPreferences>().getString(Prefrence.BRANCH)}));
      val.fold((l) =>Left(l), (r) =>Right(mapdata = r));
      final value = await repo.getLocalDBRequest(LDBParams(key: "customer", methed: DB.SET, table: DBTable.customerdata,data: mapdata));
      // await repo.getLocalDBRequest(LDBParams(key: "customer", methed: DB.GET, table: DBTable.customerdata));
      return  Future.value(value.fold((l) =>Left(l), (r) =>Right( GetCustomerProfile.fromJson(r))));
    }else{
      final value = await repo.getLocalDBRequest(LDBParams(key: "customer", methed: DB.REMOVE, table: DBTable.customerdata));
      // await repo.getLocalDBRequest(LDBParams(key: "customer", methed: DB.GET, table: DBTable.customerdata));
      return  Future.value(value.fold((l) =>Left(l), (r) =>Right( GetCustomerProfile.fromJson(r))));

    }

  }
}
class CustomerProfileParam {
  final u_id;
  final DB method;
  CustomerProfileParam({this.u_id,required this.method});

}