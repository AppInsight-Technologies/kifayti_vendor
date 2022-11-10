import 'package:dartz/dartz.dart';
//import '../..//feautures/grocbay_pos/domain/entities/check_mobile_model.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_loyalty_model.dart';
import '../entities/check_mobile_model.dart';
import '../repositorie/repository_provider.dart';

class CheckMobileUsecase extends UseCase<MobileCheck,MobileCheckParams>{
  DependencyRepostProvider repo ;
  CheckMobileUsecase({required this.repo});

  @override
  Future<Either<Failure, MobileCheck>> call({MobileCheckParams? data}) async{
    // TODO: implement call
    checkLoyalty list;
    final value = await repo.getRequest(Params(uri: Uri.parse("customer/mobile-check"),methed: Methed.Post,data: {"mobileNumber":data!.mobileNumber,"branch":data.branch}));


    return  Future.value(value.fold((l) =>Left(l), (r) =>Right(MobileCheck.fromJson(r))));
  }

}
class MobileCheckParams{
  late String mobileNumber;
  late String branch;
  MobileCheckParams({required this.mobileNumber, required this.branch});
}