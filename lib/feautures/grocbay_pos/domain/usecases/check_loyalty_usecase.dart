import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/Fetch_category.dart';
import '../entities/check_loyalty_model.dart';
import '../entities/get_loyalty_model.dart';
import '../repositorie/repository_provider.dart';

class CheckLoyaltyUsecase extends UseCase<checkLoyalty,CheckLoyaltyParams>{
  DependencyRepostProvider repo ;
  CheckLoyaltyUsecase(this.repo);

  @override
  Future<Either<Failure, checkLoyalty>> call({CheckLoyaltyParams? data}) async{
    // TODO: implement call
    checkLoyalty list;
    final value = await repo.getRequest(Params(uri: Uri.parse("check-loyalty/${data!.total}/${data.branch}"),methed: Methed.Get,data: {}));

    return  Future.value(value.fold((l) =>Left(l), (r) =>Right(checkLoyalty.fromJson(r))));
  }

}
class CheckLoyaltyParams{
  late String total;
  late String branch;
  CheckLoyaltyParams({required this.total, required this.branch});
}